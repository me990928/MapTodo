//
//  ContentView.swift
//  MapTodo
//
//  Created by Yuya Hirose on 2024/01/22.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.pageNum) {
            TimeLine().tabItem {
                Image(systemName: "doc.plaintext")
                Text("Datail")
            }.tag(0)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("TabBackgroundColor"), for: .tabBar)
            AddData(addVM: AddViewModel()).tabItem {
                Image(systemName: "square.and.pencil")
                Text("Add")
            }.tag(1)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("TabBackgroundColor"), for: .tabBar)
            Settings(setteingVM: SettingsViewModel())
                .tabItem {
                    Image(systemName: "gearshape")
                Text("Settings")
                }.tag(2)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("TabBackgroundColor"), for: .tabBar)
        }
        
    }
}

#Preview {
    ContentView()
}

