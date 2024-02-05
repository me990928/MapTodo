//
//  AddDataModel.swift
//  MapTodo
//
//  Created by Yuya Hirose on 2024/01/22.
//

import Foundation

struct AddDataModel {
    // 入力データ
    var title: String = ""
    var subTitle: String = ""
    var address: String = ""
    
    // 経度緯度
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    // 作成開始の合図
    var creatingFlag: Bool = false
}
