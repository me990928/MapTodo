//
//  TimeLine.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI
import SwiftData

struct TimeLine: View {
    
    let toolbox = ToolBox()
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \MapDataModel.registDate, order: .reverse) private var items: [MapDataModel]
    @State var deleteAlert: Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                
                ForEach(items) { data in
                    
                    NavigationLink {
                        LargeData(data: data).padding()
                    } label: {
                        SmallData(data: data)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(data.endFlag ? "未完了" : "完了"){
                            endFlagAct(data: data, flag: !data.endFlag) { Bool in
                                toolbox.feedBack(mode: "success")
                            }
                        }
                        Button("削除", role: .destructive) {
                            delact(del: data) { Bool in
                                toolbox.feedBack(mode: "success")
                            }
                        }
                    }))
                    
                }
                
//                NavigationLink {
//                    LargeData().padding()
//                } label: {
//                    SmallData(data: <#MapDataModel#>)
//                }

            }.navigationTitle("Todo一覧").padding(.top)
        }
    }
    
    
    
    // 削除処理
    func delact(del: MapDataModel,complete: @escaping (Bool)->Void){
        
        self.modelContext.delete(del)
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
}

#Preview {
    TimeLine()
}
