//
//  LargeDataViewModel.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/23.
//

import Foundation
import SwiftData

class LargeDataViewModel: ObservableObject {
    @Published var model = LargeDataModel()
    
    let tools = ToolBox()
    let locationMan = LocationManager()
    
    // 更新
    func update(data: MapDataModel, modelContext: ModelContext,complete: @escaping (Bool)->Void){
        
        let newItem = MapDataModel(id: data.id, title: model.title, subTitle: model.subTitle, lat: data.lat, lon: data.lon, registDate: data.registDate, endDate: data.endDate, endFlag: model.todoFlag, mapMode: data.mapMode, mapMemo: model.memoData)
        
        if !model.address.isEmpty {
            locationMan.geocoding(address: model.address) { lat, lon in
                newItem.lat = lat
                newItem.lon = lon
                
                print("class in \(lat)")
                
                modelContext.insert(newItem)
                
                do {
                    try modelContext.save()
//                    print("success \(newItem.lat)")
                    self.locationMan.regeocoding(lon: data.lon, lat: data.lat) { addr in
                        self.model.address = addr
                        
                        complete(true)
                    }
                } catch {
                    print("faild")
                    complete(false)
                }
            }
        }else {
            modelContext.insert(newItem)
            
            do {
                try modelContext.save()
                complete(true)
            } catch {
                complete(false)
            }
        }
        
    }
    
    // 完了処理
    func endFlagAct(data:MapDataModel, flag:Bool, modelContext: ModelContext, complete: @escaping (Bool)->Void){
        
        let newItem = MapDataModel(id: data.id, title: data.title, subTitle: data.subTitle, lat: data.lat, lon: data.lon, registDate: data.registDate, endDate: Date(), endFlag: flag, mapMode: data.mapMode, mapMemo: data.mapMemo)
        
        modelContext.insert(newItem)
        
        do {
            try modelContext.save()
            complete(true)
        } catch {
            complete(false)
        }
        
    }
    
    // 削除処理
    func delact(data: MapDataModel,modelContext: ModelContext,complete: @escaping (Bool)->Void){
        
        modelContext.delete(data)
        
        do {
            try modelContext.save()
            complete(true)
        } catch {
            complete(false)
        }
    }
    
}
