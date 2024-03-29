//
//  updateSheet.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/23.
//

import SwiftUI

struct UpdateSheet: View {
    
    @StateObject var largeVM: LargeDataViewModel
    // 親ビューから
    @Binding var data: MapDataModel
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack{
            ScrollView{
                
                HStack{
                    Text("タイトル").bold()
                    Spacer()
                }.padding(.top)
                HStack{
                    TextField("タイトル", text: $largeVM.model.title)
                    Spacer()
                }
                
                Divider()
                
                HStack{
                    Text("サブタイトル").bold()
                    Spacer()
                }
                HStack{
                    TextField("サブタイトル", text: $largeVM.model.subTitle)
                    Spacer()
                }
                
                Divider()
                
                HStack{
                    Text("住所").bold()
                    Spacer()
                }
                VStack{
                    HStack{
                        TextField("住所", text: $largeVM.model.address)
                    }.onAppear(){
                        largeVM.model.originalAddress = largeVM.model.address
                    }
                }
                
                Divider()
                
                HStack{
                    Text("メモ").bold()
                    Spacer()
                }
                VStack{
                    HStack{
                        TextEditor(text: $largeVM.model.memoData).frame(width: .infinity, height: 100)
                    }
                }
                
                Divider()
                Button("完了"){
                    largeVM.model.sheetUpdateFlag.toggle()
                    largeVM.update(data: data, modelContext: modelContext) { _ in
                        largeVM.model.sheetUpdateFlag.toggle()
                        largeVM.model.toolButton.toggle()
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                .interactiveDismissDisabled()
                .padding(.top)
                .onAppear(){
                    largeVM.model.title = data.title
                    largeVM.model.subTitle = data.subTitle
                    largeVM.model.memoData = data.mapMemo
                }
                Spacer()
            }.padding([.trailing, .leading])
        }
        
        if largeVM.model.sheetUpdateFlag {
                VStack{
                    ProgressView()
                    Text("編集中").padding()
                }.frame(width: 300, height: 300).background(Material.ultraThinMaterial).cornerRadius(10)
                Color.white.opacity(0).frame(width: .infinity, height: .infinity)
        }
    }
    
}
