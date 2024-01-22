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
    
    let toolbox = ToolBox()
    
    // デバッグ用
    let locationMan = LocationManager()
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [MapDataModel]
    
    @State var awTog: Bool = true
    @State var dataResetFlag: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            List{
                
                HStack{
                    Text("AppleWatchとの接続")
                    Spacer()
                    Toggle("", isOn: $awTog).frame(width: 50).disabled(true)
                }
                
                Button {
                    dataResetFlag.toggle()
                } label: {
                    Text("データを全て削除する").foregroundStyle(Color.red)
                }
                
                .alert("確認", isPresented: $dataResetFlag) {
                    Button("戻る", role: .cancel){
                        
                    }
                    Button("削除する", role: .destructive){
                        try! modelContext.delete(model: MapDataModel.self, includeSubclasses: true)
                        toolbox.feedBack(mode: "success")
                    }
                } message: {
                    Text("削除を実行します")
                }
            }
        }
    }
}

#Preview {
    Settings()
}
