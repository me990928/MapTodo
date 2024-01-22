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

    var body: some View {
        TabView {
            TimeLine().tabItem {
                Image(systemName: "doc.plaintext")
                Text("Datail")
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("TabBackgroundColor"), for: .tabBar)
            AddData(addVM: AddViewModel()).tabItem {
                Image(systemName: "square.and.pencil")
                Text("Add")
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("TabBackgroundColor"), for: .tabBar)
            Settings()
                .tabItem {
                    Image(systemName: "gearshape")
                Text("Settings")
                }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color("TabBackgroundColor"), for: .tabBar)
        }
        
    }
}

#Preview {
    ContentView()
}

