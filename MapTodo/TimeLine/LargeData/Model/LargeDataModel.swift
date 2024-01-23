//
//  LargeDataModel.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/23.
//

import Foundation

struct LargeDataModel {
    // 設定用
    @State var device: String = ""
    
    // DataView用
    var toolButton: Bool = false
    var todoFlag: Bool = false
    var updateFlag: Bool = false
    var deleteAlert: Bool = false
    
    // sheet用
    var title: String = ""
    var subTitle: String = ""
    var memoData: String = ""
    var address: String = ""
    var originalAddress: String = ""
}
