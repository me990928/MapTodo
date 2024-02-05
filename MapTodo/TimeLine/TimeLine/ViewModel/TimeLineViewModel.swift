//
//  TimeLineViewModel.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/24.
//

import Foundation

class TimeLineViewModel: ObservableObject {
    
    @Published var timelineVM = TimeLineModel()
    
    let toolbox = ToolBox()
    
}
