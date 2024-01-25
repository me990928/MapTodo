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
                        Text(data.title).bold()
                        Spacer()
                        Text(smallVM.tools.formatDate(date: data.registDate)).foregroundStyle(.gray).font(.caption)
                    }
                    Text(data.subTitle)
                }
                Spacer()
            }
            if mapDisplay {
                MapCard(controlFlag: false, data: $data)
            } else {
                HStack{
                    Text(data.mapMemo).foregroundStyle(Color(.label))
                    Spacer()
                }
            }
            
            HStack{
                Spacer()
                data.endFlag ? Text("\(smallVM.tools.formatDate(date: data.endDate)) 完了").foregroundStyle(.gray).font(.caption) : nil
            }
        }
    }
}
