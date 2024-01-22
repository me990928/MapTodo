//
//  AddData.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI
import SwiftData

struct AddData: View {
    
    
    @Environment(\.modelContext) private var modelContext
    
    @StateObject var addVM: AddViewModel
    
    var body: some View {
        
        ZStack{
            VStack{
                Text("Todo作成").font(.title)
                Group{
                    VStack{
                        HStack{
                            Text("タイトル").bold()
                            Spacer()
                        }
                        HStack{
                            TextField("タイトル", text: $addVM.addModel.title)
                            Spacer()
                        }
                        Divider()
                    }.padding()
                }
                
                Group{
                    VStack{
                        HStack{
                            Text("サブタイトル").bold()
                            Spacer()
                        }
                        HStack{
                            TextField("サブタイトル", text: $addVM.addModel.subTitle)
                            Spacer()
                        }
                        Divider()
                    }.padding()
                }
                
                Group{
                    VStack{
                        HStack{
                            Text("住所登録").bold()
                            Spacer()
                            Button("取得"){
                                addVM.setLocation()
                            }.disabled(addVM.addModel.creatingFlag)
                        }
                        HStack{
//                            Text(address)
                            TextField("住所を入力するか現在位置から取得してください", text: $addVM.addModel.address)
                            Spacer()
                        }
                    }.padding()
                }
                
                Button("作成"){
                    addVM.addModel.creatingFlag.toggle()
                    
//                    act { _ in
//                        addVM.addModel.creatingFlag .toggle()
//                        tools.feedBack(mode: "success")
//                    }
                    
                    addVM.regist { Bool in
                        addVM.addModel.creatingFlag .toggle()
                        print("view:\(addVM.addModel.lat)")
                        let newItem = MapDataModel(id: UUID().uuidString, title: addVM.addModel.title.isEmpty ? "No title" : addVM.addModel.title, subTitle: addVM.addModel.subTitle, lat: addVM.addModel.lat, lon: addVM.addModel.lon, registDate: Date(), endDate: Date(), endFlag: false, mapMode: true, mapMemo: "")
                        self.modelContext.insert(newItem)
                        addVM.tools.feedBack(mode: "success")
                    }
                    
                    // 登録完了後、TLに飛ぶ
                    
                }.buttonStyle(.borderedProminent).padding()
                
                Spacer()
            }
            if addVM.addModel.creatingFlag {
                ZStack{
                    VStack{
                        ProgressView()
                        Text("作成中").padding()
                    }.frame(width: 300, height: 300).background(Material.ultraThinMaterial).cornerRadius(10)
                    Color.white.opacity(0).frame(width: .infinity, height: .infinity)
                }
            }
        }.onDisappear(){
            self.addVM.addModel.title = ""
            self.addVM.addModel.subTitle = ""
            self.addVM.addModel.address = ""
            self.addVM.addModel.lat = 0.0
            self.addVM.addModel.lon = 0.0
        }
    }
    
}

#Preview {
    AddData(addVM: AddViewModel())
}
