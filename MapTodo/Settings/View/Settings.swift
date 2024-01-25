//
//  Settings.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI
import SwiftData

// マップの描写モードのデフォ設定
// マップの初回タップフラグの設定

struct Settings: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [MapDataModel]
    
    @StateObject var setteingVM: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            List{
                
                HStack{
                    Text("AppleWatchとの接続")
                    Spacer()
                    Toggle("", isOn: $setteingVM.settingModel.awTog).frame(width: 50).disabled(true)
                }
                
                NavigationLink {
                    MapViewSettings(SettingVM: setteingVM)
                } label: {
                    Text("マップの表示設定")
                }

                
                Button {
                    setteingVM.settingModel.dataResetFlag.toggle()
                } label: {
                    Text("データを全て削除する").foregroundStyle(Color.red)
                }
                
                .alert("確認", isPresented: $setteingVM.settingModel.dataResetFlag
                ) {
                    Button("戻る", role: .cancel){
                        
                    }
                    Button("削除する", role: .destructive){
                        try! modelContext.delete(model: MapDataModel.self, includeSubclasses: true)
                            setteingVM.toolbox.feedBack(mode: "success")
                    }
                } message: {
                    Text("削除を実行します")
                }
            }
        }
    }
}

#Preview {
    Settings(setteingVM: SettingsViewModel())
}
