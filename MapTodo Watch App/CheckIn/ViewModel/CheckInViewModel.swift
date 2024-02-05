//
//  CheckInViewModel.swift
//  MapTodo Watch App
//
//  Created by 広瀬友哉 on 2024/01/29.
//

import Foundation

class CheckInViewModel: ObservableObject{
    @Published var model = CheckInModel()
    let locationMan = LocationManager()
    let phone = PhoneRecever()
    
    // latiudeのセット
    private func setLat(_ lat:Double){
        model.lat = lat
    }
    
    // Longtiudeのセット
    private func setLon(_ lon:Double){
        model.lon = lon
    }
    
    // testMethod
    public func setLocation(complete:@escaping ()->Void){
        print("1")
        
        setLat(locationMan.latiude)
        setLon(locationMan.longitude)
            
        locationMan.regeocoding(lon: model.lon, lat: model.lat) { addr in
            self.model.address = String(addr)
            self.phone.transfer(data: self.model.model)
            
            complete()
        }
    }
    
    // 試験用
//    private func sendMSG(){
//        phone.TestSender()
//    }
    
}
