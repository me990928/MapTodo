//
//  CheckInModel.swift
//  MapTodo Watch App
//
//  Created by 広瀬友哉 on 2024/01/29.
//

import Foundation

struct CheckInModel {
    var flag: Bool = false
    var lat: Double = 0.0
    var lon: Double = 0.0
    var address: String = ""
    
    var model: WatchMapDataModel = WatchMapDataModel(id: UUID().uuidString, title: "", subTitle: "", lat: 0.0, lon: 0.0, registDate: Date(), endDate: Date(), endFlag: false, mapMode: true, mapMemo: "", addLater: true)
}
