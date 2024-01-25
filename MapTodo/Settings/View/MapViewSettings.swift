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
    
    // 制御用
    @Environment(\.presentationMode) var presentation
    var body: some View {
        List(){
            Button{
                SettingVM.mapStyleChangeMap(data: items, modelContext: self.modelContext) { Bool in
                    self.SettingVM.toolbox.feedBack(mode: "success")
                    self.presentation.wrappedValue.dismiss()
                }
                
                
            } label: {
                Text("マップ表示を全て地図に変更する").foregroundStyle(Color(.label))
            }
            
            Button{
                
            } label: {
                Text("タイムラインのマップ表示をメモに変更する").foregroundStyle(Color(.label))
            }
        }
    }
}

#Preview {
    MapViewSettings(SettingVM: SettingsViewModel())
}
