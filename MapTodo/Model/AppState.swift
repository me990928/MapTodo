//
//  AppState.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/24.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var pageNum: Int = 0
    @Published var path = NavigationPath()
}
