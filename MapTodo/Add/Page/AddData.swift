//
//  AddData.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI
import SwiftData

struct AddData: View {
    
    let tools = ToolBox()
    let locationMan = LocationManager()
    
    @Environment(\.modelContext) private var modeContext
    
    @State var title: String = ""
    @State var subTitle: String = ""
    @State var address: String = ""
    
    @State var lat: Double = 0.0
    @State var lon: Double = 0.0
    
    @State var creatingFlag: Bool = false
    
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
                            TextField("タイトル", text: $title)
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
                            TextField("サブタイトル", text: $subTitle)
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
                                lat = locationMan.latiude
                                lon = locationMan.longitude
                                
                                locationMan.regeocoding(lon: lon, lat: lat) { addr in
                                    self.address = addr
                                    tools.feedBack(mode: "success")
                                }
                            }.disabled(creatingFlag)
                        }
                        HStack{
//                            Text(address)
                            TextField("住所を入力するか現在位置から取得してください", text: $address)
                            Spacer()
                        }
                    }.padding()
                }
                
                Button("作成"){
                    creatingFlag.toggle()
                    
                    act { _ in
                        creatingFlag .toggle()
                        tools.feedBack(mode: "success")
                    }
                    
                    // 登録完了後、TLに飛ぶ
                    
                }.buttonStyle(.borderedProminent).padding()
                
                Spacer()
            }
            if creatingFlag {
                ZStack{
                    VStack{
                        ProgressView()
                        Text("作成中").padding()
                    }.frame(width: 300, height: 300).background(Material.ultraThinMaterial).cornerRadius(10)
                    Color.white.opacity(0).frame(width: .infinity, height: .infinity)
                }
            }
        }.onDisappear(){
            self.title = ""
            self.subTitle = ""
            self.address = ""
            self.lat = 0.0
            self.lon = 0.0
        }
    }
    
    
    // 登録関数
    func act(complete: @escaping (Bool)->Void){
        
        if self.lon == 0.000000 && self.lat == 0.000000 && !address.isEmpty {
            locationMan.geocoding(address: self.address){ lat, lon in
                print(lat)
                print(lon)
                self.lat = lat
                self.lon = lon
            }
        }
        
        let newItem = MapDataModel(id: UUID().uuidString, title: self.title.isEmpty ? "No title" : self.title, subTitle: self.subTitle, lat: self.lat, lon: self.lon, registDate: Date(), endDate: Date(), endFlag: false, mapMode: true, mapMemo: "")
        
        self.modeContext.insert(newItem)
        
        complete(true)
    }
    
    func rest(){
        self.title = ""
        self.subTitle = ""
    }
}

#Preview {
    AddData()
}
