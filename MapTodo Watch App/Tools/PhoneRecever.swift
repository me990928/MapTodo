//
//  PhoneRecever.swift
//  MapTodo Watch App
//
//  Created by 広瀬友哉 on 2024/01/29.
//

import Foundation
import WatchConnectivity

class PhoneRecever: NSObject,ObservableObject, WCSessionDelegate {
    
    @Published var count:Int = 0
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("The session has cpmpleted activation.")
        }
    }
    
    private var session: WCSession
    // phoneの疎通確認
    @Published var phoneStatus:Bool = false
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func transfer(data: WatchMapDataModel){
        
        guard session.activationState == .activated else {
            print("送信先がアクティブではありません")
            return
        }
        
        Task.detached(priority: .medium) { [self] in
            let userInfo = try! JSONEncoder().encode(data)
            print(userInfo)
            print(type(of: userInfo))
            session.transferUserInfo(["modelData" : userInfo])
        }
        
    }
    
}
