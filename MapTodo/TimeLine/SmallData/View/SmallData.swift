//
//  SmallData.swift
//  haldegign
//
//  Created by 広瀬友哉 on 2024/01/13.
//

import SwiftUI

struct SmallData: View {
    
    let tools = ToolBox()
    
    @State var data: MapDataModel
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(data.title).bold()
                        Spacer()
                        Text(tools.formatDate(date: data.registDate)).foregroundStyle(.gray).font(.caption)
                    }
                    Text(data.subTitle)
                }
                Spacer()
            }
            MapCard(controlFlag: false, data: data)
            HStack{
                Spacer()
                data.endFlag ? Text("\(tools.formatDate(date: data.endDate)) 完了").foregroundStyle(.gray).font(.caption) : nil
            }
        }
    }
}