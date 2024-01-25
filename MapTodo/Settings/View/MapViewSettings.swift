//
//  MapViewSettings.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/26.
//

import SwiftUI
import SwiftData

struct MapViewSettings: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [MapDataModel]
    
    @StateObject var SettingVM: SettingsViewModel
    
    @AppStorage ("mapDisplay") var mapDisplay: Bool = true
    
    // 制御用
    @Environment(\.presentationMode) var presentation
    var body: some View {
        List(){
            Button{
                SettingVM.mapStyleChangeMap(data: items, modelContext: self.modelContext) { Bool in
                    self.SettingVM.toolbox.feedBack(mode: "change")
                    self.presentation.wrappedValue.dismiss()
                }
            } label: {
                Text("マップ表示を全て地図に変更する").foregroundStyle(Color(.label))
            }
            
            Toggle(isOn: $mapDisplay) {
                Text("タイムラインのマップ表示")
            }.onChange(of: mapDisplay) {
                SettingVM.toolbox.feedBack(mode: "change")
            }
        }
    }
}

#Preview {
    MapViewSettings(SettingVM: SettingsViewModel())
}
