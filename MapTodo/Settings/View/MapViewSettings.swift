//
//  MapViewSettings.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/26.
//

import SwiftUI

struct MapViewSettings: View {
    // 制御用
    @Environment(\.presentationMode) var presentation
    var body: some View {
        List(){
            Button{
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("マップ表示を全て地図に変更する")
            }
        }
    }
}

#Preview {
    MapViewSettings()
}
