//
//  MapDataModel.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/15.
//

import Foundation
import SwiftData

@Model
final class MapDataModel {
    
    @Attribute(.unique) var id: String
    
    var title:String
    
    var subTitle:String
    
    var lat: Double
    
    var lon: Double
    
    var registDate: Date
    
    var endDate: Date
    
    var endFlag: Bool
    
    var mapMode: Bool
    
    var mapMemo: String
    
//    init(timestamp: Date) {
//        self.timestamp = timestamp
//    }
    
    init(id: String, title: String, subTitle: String, lat: Double, lon: Double, registDate: Date, endDate: Date, endFlag: Bool, mapMode: Bool, mapMemo: String) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.lat = lat
        self.lon = lon
        self.registDate = registDate
        self.endDate = endDate
        self.endFlag = endFlag
        self.mapMode = mapMode
        self.mapMemo = mapMemo
    }
}
