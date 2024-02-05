//
//  WatchMapDataModel.swift
//  MapTodo Watch App
//
//  Created by 広瀬友哉 on 2024/01/29.
//

import Foundation
import SwiftData

struct WatchMapDataModel:Codable {
    
    var id: String
    
    var title:String
    
    var subTitle:String
    
    var lat: Double
    
    var lon: Double
    
    var registDate: Date
    
    var endDate: Date
    
    var endFlag: Bool
    
    var mapMode: Bool
    
    var mapMemo: String
    
    var addLater: Bool
}

@Model
final class RegistWatchMapDataModel {
    
    @Attribute(.unique) var id: String
    
    var registData: WatchMapDataModel
    
    var sendCheck: Bool
    
    init(id: String, registData: WatchMapDataModel, sendCheck: Bool) {
        self.id = id
        self.registData = registData
        self.sendCheck = sendCheck
    }
}
