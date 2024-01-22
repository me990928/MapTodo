//
//  AddViewModel.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/22.
//

import Foundation
import SwiftData

class AddViewModel: ObservableObject {
    
    @Published var addModel = AddDataModel()
    
    let tools = ToolBox()
    
    let locationMan = LocationManager()
    
    // latiudeのセット
    private func setLat(_ lat:Double){
        addModel.lat = lat
    }
    
    // Longtiudeのセット
    private func setLon(_ lon:Double){
        addModel.lon = lon
    }
    
    // 住所データ取得
    public func setLocation(){
        setLat(locationMan.latiude)
        setLon(locationMan.longitude)
            
        locationMan.regeocoding(lon: addModel.lon, lat: addModel.lat) { addr in
            self.addModel.address = String(addr)
            self.tools.feedBack(mode: "success")
        }
    }
    
    // 登録実行関数
    public func regist(complete: @escaping (Bool)->Void){
        
        if addModel.lon == 0.000000 && addModel.lat == 0.000000 && !addModel.address.isEmpty {
            locationMan.geocoding(address: addModel.address){ lat, lon in
                // 住所からデータを取得
                print(lat)
                print(lon)
                self.setLat(lat)
                self.setLon(lon)
                // なぜかsetした値が0になる
                // 値の推移を確認して確認する
                print("class:\(self.addModel.lat)")
                complete(true)
            }
        }else{
            // 位置情報のみで取得
            print("class:\(self.addModel.lat)")
            complete(true)
        }
        
//        self.modeContext.insert(newItem)
    }
    
    public func rest(){
        addModel.title = ""
        addModel.subTitle = ""
    }
}
