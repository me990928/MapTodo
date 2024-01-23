//
//  LargeDataViewModel.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/23.
//

import Foundation

class LargeDataViewModel: ObservableObject {
    @Published var model = LargeDataModel()
    
    let tools = ToolBox()
    let locationMan = LocationManager()
}
