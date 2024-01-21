//
//  LargeData.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI
import MapKit
import SwiftData

struct LargeData: View {
    
    @State var device: String = ""
    
    let tools = ToolBox()
    let locationMan = LocationManager()
    
    @Environment(\.modelContext) private var modelContext
    
    @State var data: MapDataModel
    
    @State var toolButton: Bool = false
    
    @State var todoFlag: Bool = false
    
    @State var updateFlag: Bool = false
    
    @State var deleteAlert: Bool = false
    
    // sheet用
    @State var title: String = ""
    @State var subTitle: String = ""
    @State var memoData: String = ""
    @State var address: String = ""
    @State var originalAddress: String = ""
    
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                HStack{
                    Text(data.title).bold().font(.title)
                    Spacer()
                    
                    Button {
                        deleteAlert.toggle()
                    } label: {
                        Image(systemName: "trash").tint(Color.red)
                    }
                    .alert("警告", isPresented: $deleteAlert) {
                        Button("削除", role: .destructive){
                            // データ削除処理
                            delact { _ in
                                tools.feedBack(mode: "success")
                                self.presentation.wrappedValue.dismiss()
                            }
                        }
                    } message: {
                        Text("データが削除されますが、よろしいですか?")
                    }
                }
                
                Divider()
                
                HStack{
                    Text(data.subTitle)
                    Spacer()
                }
                
                Divider()
                
                VStack{
                    HStack{
                        Text(data.mapMemo.isEmpty ? "編集からメモを書き込むことができます" : data.mapMemo).foregroundStyle(data.mapMemo.isEmpty ? Color.gray : Color(UIColor.label))
                        Spacer()
                    }
                }
                
                Divider()
                
                VStack{
                    HStack{
                        Text("登録：" + tools.formatDate(date: data.registDate))
                        Spacer()
                    }
                    HStack{
                        Text("状況：\(todoFlag ? "完了" : "未完了")")
                        Spacer()
                        Toggle("", isOn: $todoFlag).padding(.trailing)
                    }.onChange(of: todoFlag) { oldValue, newValue in
                        endFlagAct(data: data, flag: todoFlag) { Bool in
                        }
                    }
                    .onAppear(){
                        todoFlag = data.endFlag
                    }
                }
                
                Divider()
                
                HStack{
                    Text("住所")
                    Spacer()
                }
                
                HStack{
                    Text(address)
//                    Text("lat:\(data.lat), lon:\(data.lon)")
                    Spacer()
                }.onAppear(){
                    locationMan.regeocoding(lon: data.lon, lat: data.lat) { addr in
                        self.address = addr
                    }
                }

                Divider()
                MapCard(controlFlag: true, data: data)
                
                Spacer()
            }.padding(.bottom, 50)
        }.navigationTitle("Todo")
            .navigationBarItems(trailing: Button("編集"){
                toolButton.toggle()
            })
            .sheet(isPresented: $toolButton, content: {
                ScrollView{
                
                    HStack{
                        Text("タイトル").bold()
                        Spacer()
                    }.padding(.top)
                    HStack{
                        TextField("タイトル", text: $title)
                        Spacer()
                    }
                    
                    Divider()
                        
                    HStack{
                        Text("サブタイトル").bold()
                        Spacer()
                    }
                    HStack{
                        TextField("サブタイトル", text: $subTitle)
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("住所").bold()
                        Spacer()
                    }
                    VStack{
                        HStack{
                            TextField("住所", text: $address)
                        }.onAppear(){
                            originalAddress = address
                        }
                    }
                    
                    Divider()
                    
                    HStack{
                        Text("メモ").bold()
                        Spacer()
                    }
                    VStack{
                        HStack{
                            TextEditor(text: $memoData).frame(width: .infinity, height: 100)
                        }
                    }
                        
                    Divider()
                    Button("完了"){
                        act { _ in
                            toolButton.toggle()
                        }
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .interactiveDismissDisabled()
                    .padding(.top)
                    .onAppear(){
                        self.title = data.title
                        self.subTitle = data.subTitle
                        self.memoData = data.mapMemo
                    }
                    Spacer()
                }.padding([.trailing, .leading])
            })
    }
    
    
    // 更新関数
    func act(complete: @escaping (Bool)->Void){
        
        let newItem = MapDataModel(id: data.id, title: self.title, subTitle: self.subTitle, lat: data.lat, lon: data.lon, registDate: data.registDate, endDate: data.endDate, endFlag: todoFlag, mapMode: data.mapMode, mapMemo: self.memoData)
        
        self.modelContext.insert(newItem)
        
        try! self.modelContext.save()
        
        complete(true)
    }
    
    // 完了処理
    func endFlagAct(data:MapDataModel, flag:Bool, complete: @escaping (Bool)->Void){
        
        let newItem = MapDataModel(id: data.id, title: data.title, subTitle: data.subTitle, lat: data.lat, lon: data.lon, registDate: data.registDate, endDate: Date(), endFlag: flag, mapMode: data.mapMode, mapMemo: data.mapMemo)
        
        self.modelContext.insert(newItem)
        
        try! self.modelContext.save()
        
        complete(true)
    }
    
    // 削除処理
    func delact(complete: @escaping (Bool)->Void){
        
        self.modelContext.delete(self.data)
        try! self.modelContext.save()
        
        complete(true)
    }
    
    
}
