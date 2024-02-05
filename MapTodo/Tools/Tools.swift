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
    
    // 触覚制御
    func feedBack(mode: String){
        
        let UINFGenerator = UINotificationFeedbackGenerator()
        let UIIFGeneratorHeavy = UIImpactFeedbackGenerator(style: .heavy)
        let UIIFGeneratorMedium = UIImpactFeedbackGenerator(style: .medium)
        let UIIFGeneratorLight = UIImpactFeedbackGenerator(style: .light)
        let UISFGenerator = UISelectionFeedbackGenerator()
        
        switch(mode){
        case "success":
            UINFGenerator.notificationOccurred(.success)
            break
        case "error":
            UINFGenerator.notificationOccurred(.error)
            break
        case "warning":
            UINFGenerator.notificationOccurred(.warning)
            break
        case "heavy":
            UIIFGeneratorHeavy.impactOccurred()
            break
        case "medium":
            UIIFGeneratorMedium.impactOccurred()
            break
        case "light":
            UIIFGeneratorLight.impactOccurred()
            break
        case "change":
            UISFGenerator.selectionChanged()
            break
        default:
            UIIFGeneratorMedium.impactOccurred()
        }
    }
    
    // デバイス判断
    func searchdevice()->String {
        
        var dev: String = ""
        
        switch UIDevice.current.userInterfaceIdiom{
        case .phone:
            dev = "phone"
        case .pad:
            dev = "pad"
        case .unspecified:
            dev = "unspecified"
        case .tv:
            dev = "tv"
        case .carPlay:
            dev = "carPlay"
        case .mac:
            dev = "mac"
        case .vision:
            dev = "vision"
        @unknown default:
            dev = "unkown"
        }
        return dev
    }
    
}
