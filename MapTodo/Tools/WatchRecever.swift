//
//  WatchRecever.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/29.
//

import Foundation
import SwiftData
import WatchConnectivity

class WatchRecever: NSObject, ObservableObject, WCSessionDelegate {
    
    // watchの疎通確認
    @Published var watchStatus:Bool = false
    @Published var test: MapDataModel = MapDataModel(id: "", title: "", subTitle: "", lat: 0.0, lon: 0.0, registDate: Date(), endDate: Date(), endFlag: false, mapMode: true, mapMemo: "test Now!", addLater: true)
    
    @Published var receved = [RecevedDataModel]()
    
    @Published var recevedChange: Bool = false
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("The session has cpmpleted activation.")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    private let session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        Task {
            @MainActor in
            
            print("hallo")
            
            if let val = userInfo["modelData"] as? Data {
                let modelData = try! JSONDecoder().decode(RecevedDataModel.self, from: val )
                print(modelData.endDate)
                self.receved.append(modelData)
                self.recevedChange = true
            }
        }
    }
    
}

