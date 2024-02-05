//
//  MapCard.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI
import SwiftData
import MapKit

struct identifeiblePlace: Identifiable {
    
    let id: UUID
    
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
}

enum MapStyler {
    case real
    case map
}

struct MapCard: View {
    
    let tools = ToolBox()
    @State var device: String = ""
    
    @Environment(\.modelContext) private var modelContext
    
    // 初回確認
    @AppStorage ("firstTap") var firstTap: Bool = true

    // 動作しても良いか(ユーザ任意)
    @State var controlTap: Bool = false
    
    // 前提として動作を許可するか
    @State var controlFlag: Bool
    
    @State var imageChangeFlag: Bool = false
    
    @Binding var data: MapDataModel
    
    let mapStyleReal: MapStyle = .hybrid(elevation: .realistic)
    let mapStylePaper: MapStyle = .standard
    @State var mapStyler = MapStyler.real
    
    var body: some View {
        ZStack{
            Map(){
                Marker("location",coordinate: CLLocationCoordinate2D(latitude: data.lat, longitude: data.lon))
            }.mapStyle(mapStyler == .real ? mapStyleReal : mapStylePaper).overlay(content: {
                if !controlFlag {
                    Color.white.opacity(0).frame(maxWidth: .infinity, maxHeight: device == "phone" ? 300 : 500)
                }
            }).frame(height: device == "phone" ? 300 : 500)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    if controlFlag {
                        Button{
                            controlTap.toggle()
                        } label: {
                            Image(systemName: controlTap ? "play" : "stop")
                        }.buttonStyle(.borderedProminent)
                    }
                    Button {
                        self.mapStyler = mapStyler == .real ? .map : .real
                        self.update()
                    } label: {
                        Image(systemName: mapStyler == .real ? "map" : "photo")
                    }.buttonStyle(.borderedProminent)

                }.padding([.bottom, .trailing], 5)
            }.frame(height: device == "phone" ? 300 : 500)
            
            
            if !controlTap {
                Color.white.opacity(0).frame(maxWidth: .infinity, maxHeight: device == "phone" ? 300 : 500)
            }
            
            if firstTap && controlFlag {
                Group{
                    Color.black.opacity(0.5).frame(width: .infinity, height: device == "phone" ? 300 : 500)
                    Text("マップの操作ができます").bold().foregroundStyle(.white)
                }.onTapGesture {
                    firstTap.toggle()
                }
            }
            
            
        }.onAppear(){
            if firstTap {
                controlTap = true
            }
            mapStyler = data.mapMode ? .real : .map
            
            // デバイスを判断して高さを変える
            device = tools.searchdevice()
        }
    }
    
    func update(){
        let updateModel = MapDataModel(id: data.id, title: data.title, subTitle: data.subTitle, lat: data.lat, lon: data.lon, registDate: data.registDate, endDate: data.endDate, endFlag: data.endFlag, mapMode: mapStyler == .real ? true : false, mapMemo: data.mapMemo, addLater: data.addLater)
        
        modelContext.insert(updateModel)
        
        try! modelContext.save()
    }
    
}

//#Preview {
//    MapCard(controlFlag: false, mapMode: true)
//}
