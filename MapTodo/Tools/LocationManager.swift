//
//  LocationManager.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/15.
//

import Foundation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    var region = MKCoordinateRegion()
    
    var latiude:Double = 0.0
    var longitude:Double = 0.0
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization() // 使用許可
        manager.desiredAccuracy = kCLLocationAccuracyBest   // 追跡制度
        manager.distanceFilter = 3.0    // 更新頻度
        manager.startUpdatingLocation() // 領域更新処理
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(
                latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude
            )
            latiude = $0.coordinate.latitude
            longitude = $0.coordinate.longitude
            region = MKCoordinateRegion(center: center, latitudinalMeters: 1000.0, longitudinalMeters: 1000.0)
        }
    }
    
    // ジオコーディング
    func geocoding(address: String, complation:@escaping ((_ lat: Double, _ lon: Double)->Void)){
        var lon: Double = 0
        var lat: Double = 0
           let geocoder = CLGeocoder()
        print(address)
           geocoder.geocodeAddressString(address) { (placemarks, error) in
               if let latg = placemarks?.first?.location?.coordinate.latitude {
                   print("緯度 : \(latg)")
                   lat = latg
                   
               }
               if let long = placemarks?.first?.location?.coordinate.longitude {
                   print("経度 : \(long)")
                   lon = long
               }
               complation(lat,lon)
           }
        
//        complation(lat, lon)
       }
       
    func regeocoding(lon:Double, lat:Double, comp:@escaping (_ addr: String)->Void){
        
        var address: String = ""
        
//            let location = CLLocation(latitude: 35.148892, longitude: 136.853034)
            let location = CLLocation(latitude: lat, longitude: lon)
           
           let geocoder = CLGeocoder()
           geocoder.reverseGeocodeLocation(location) { placemarks, error in
               if let post = placemarks?.first {
                   print(post.postalCode as Any)
                   print(post.administrativeArea as Any)
                   print(post.subAdministrativeArea as Any)
                   print(post.locality as Any)
                   print(post.subLocality as Any)
                   print(post.thoroughfare as Any)
                   print(post.subThoroughfare as Any)
                   
                   if let post = post.postalCode {
                       address += "〒\(post)\n"
                   }
                   if let adominist = post.administrativeArea {
                       address += "\(adominist)\n"
                   }
                   if let locality = post.locality {
                       address += locality
                   }
//                   if let sublocality = post.subLocality {
//                       address += sublocality
//                   }
                   if let thoroughfare = post.thoroughfare {
                       address += thoroughfare
                   }
                   if let subThoroughfare = post.subThoroughfare {
                       address += subThoroughfare
                   }
                   
                   comp(address)
               }
           }
       }
    
}
