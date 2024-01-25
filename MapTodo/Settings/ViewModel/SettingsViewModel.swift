//
//  SettingsViewModel.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/23.
//

import Foundation
import SwiftData

class SettingsViewModel: ObservableObject {
    @Published var settingModel = SettingsModel()
    
    let toolbox = ToolBox()
    
    func mapStyleChangeMap(data: [MapDataModel], modelContext: ModelContext, complete: @escaping (Bool)->Void){
        var newData = data
        newData.forEach { MapDataModel in
            MapDataModel.mapMode = false
            modelContext.insert(MapDataModel)
            try? modelContext.save()
        }
        complete(true)
    }
}
