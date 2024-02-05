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
    @EnvironmentObject var watch: WatchRecever

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
        }.onAppear(){
            if !watch.receved.isEmpty {
                for data in watch.receved {
                    let model: MapDataModel = MapDataModel(id: data.id, title: data.title, subTitle: data.subTitle, lat: data.lat, lon: data.lon, registDate: data.registDate, endDate: data.endDate, endFlag: data.endFlag, mapMode: data.mapMode, mapMemo: data.mapMemo, addLater: data.addLater)
                    modelContext.insert(model)
                }
                watch.receved = []
            }
            print(watch.receved)
        }
        .onChange(of: watch.recevedChange) { oldValue, newValue in
            print("change")
            if !watch.receved.isEmpty {
                for data in watch.receved {
                    let model: MapDataModel = MapDataModel(id: data.id, title: data.title, subTitle: data.subTitle, lat: data.lat, lon: data.lon, registDate: data.registDate, endDate: data.endDate, endFlag: data.endFlag, mapMode: data.mapMode, mapMemo: data.mapMemo, addLater: data.addLater)
                    modelContext.insert(model)
                }
                watch.receved = []
            }
            print(watch.receved)
        }
    }
}

#Preview {
    ContentView()
}

