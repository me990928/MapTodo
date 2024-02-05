//
//  ContentView.swift
//  MapTodo Watch App
//
//  Created by Yuya Hirose on 2024/01/22.
//

// 押す→SwiftDataに保存
// 予約リストからiPhoneに送信

import SwiftUI

struct ContentView: View {
    
    @StateObject var phone = PhoneRecever()
    
    var body: some View {
        TabView {
            CheckIn()
        }.tabViewStyle(.verticalPage)
    }
    
}

#Preview {
    ContentView()
}
