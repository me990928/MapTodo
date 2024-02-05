//
//  SwiftUIView.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/23.
//

import Foundation

struct SettingsModel {
    var awTog: Bool = true
    var dataResetFlag: Bool = false
    
    // タイムライン表示設定用
    var mapData: [MapDataModel]?
    
}
