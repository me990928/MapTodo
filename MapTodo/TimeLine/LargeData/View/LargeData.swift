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
    
    // 親ビューから
    @State var data: MapDataModel
    
    @Environment(\.modelContext) private var modelContext
    // 制御用
    @Environment(\.presentationMode) var presentation
    
    @StateObject var largeVM: LargeDataViewModel
    
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                HStack{
                    Text(data.title).bold().font(.title)
                    Spacer()
                    
                    Button {
                        largeVM.model.deleteAlert.toggle()
                    } label: {
                        Image(systemName: "trash").tint(Color.red)
                    }
                    .alert("警告", isPresented: $largeVM.model.deleteAlert) {
                        Button("削除", role: .destructive){
                            // データ削除処理
                            largeVM.delact(data: data, modelContext: modelContext) { _ in
                                largeVM.tools.feedBack(mode: "success")
                                // 削除後にタイムラインに戻る
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
                        Text("登録：" + largeVM.tools.formatDate(date: data.registDate))
                        Spacer()
                    }
                    HStack{
                        Text("状況：\(largeVM.model.todoFlag ? "完了" : "未完了")")
                        Spacer()
                        Toggle("", isOn: $largeVM.model.todoFlag).padding(.trailing)
                    }.onChange(of: largeVM.model.todoFlag) { oldValue, newValue in
//                        endFlagAct(data: data, flag: largeVM.model.todoFlag) { Bool in
//                        }
                        largeVM.endFlagAct(data: data, flag: largeVM.model.todoFlag, modelContext: self.modelContext) { Bool in
                            // 削除失敗処理
                        }
                    }
                    .onAppear(){
                        largeVM.model.todoFlag = data.endFlag
                    }
                }
                
                Divider()
                
                HStack{
                    Text("住所")
                    Spacer()
                }
                
                HStack{
                    Text(largeVM.model.address)
//                    Text("lat:\(data.lat), lon:\(data.lon)")
                    Spacer()
                }.onAppear(){
                    largeVM.locationMan.regeocoding(lon: data.lon, lat: data.lat) { addr in
                        largeVM.model.address = addr
                    }
                }

                Divider()
                MapCard(controlFlag: true, data: $data)
                
                Spacer()
            }.padding(.bottom, 50)
        }.navigationTitle("Todo")
            .navigationBarItems(trailing: Button("編集"){
                largeVM.model.toolButton.toggle()
            })
            .sheet(isPresented: $largeVM.model.toolButton, content: {
                UpdateSheet(largeVM: largeVM, data: $data)
            })
    }
    
    
}
