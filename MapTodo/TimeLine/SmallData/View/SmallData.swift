//
//  SmallData.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI

struct SmallData: View {
    
    @ObservedObject var smallVM: SmallDataViewModel
    
    @State var data: MapDataModel
    
    @AppStorage ("mapDisplay") var mapDisplay: Bool = true
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(data.title).bold().multilineTextAlignment(.leading)
                        Spacer()
                        Text(smallVM.tools.formatDate(date: data.registDate)).foregroundStyle(.gray).font(.caption)
                    }
                    Text(data.subTitle).multilineTextAlignment(.leading)
                }
                Spacer()
            }
            if mapDisplay {
                MapCard(controlFlag: false, data: $data)
            } else {
                VStack(alignment: .leading){
                    HStack{
                        Text(data.mapMemo.isEmpty ? "編集からメモを書き込むことができます" : data.mapMemo).foregroundStyle(data.mapMemo.isEmpty ? Color.gray : Color(UIColor.label)).multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
            
            HStack{
                Spacer()
                data.endFlag ? Text("\(smallVM.tools.formatDate(date: data.endDate)) 完了").foregroundStyle(.gray).font(.caption) : nil
            }
        }
    }
}
