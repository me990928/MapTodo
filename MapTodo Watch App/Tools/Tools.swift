//
//  Tools.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/15.
//

import Foundation
import UIKit

class ToolBox {
    
    // Date型を"YYYY-MM-DD HH:mm:ss"へフォーマット
    func formatDate(date: Date, _ format: String = "YYYY-MM-DD HH:mm:ss") -> String {
      let formatter = DateFormatter()
      formatter.dateFormat = format
      return formatter.string(from: date)
    }
    
}
