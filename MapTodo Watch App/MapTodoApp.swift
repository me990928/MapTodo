//
//  MapTodoApp.swift
//  MapTodo Watch App
//
//  Created by Yuya Hirose on 2024/01/22.
//

import SwiftUI
import SwiftData

@main
struct MapTodo_Watch_AppApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RegistWatchMapDataModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}



