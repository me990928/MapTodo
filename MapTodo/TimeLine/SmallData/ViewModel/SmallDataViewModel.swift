//
//  SmallDataViewModel.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/24.
//

import Foundation

class SmallDataViewModel: ObservableObject {
    @Published var model = SmallDataModel()
    
    let tools = ToolBox()
}
