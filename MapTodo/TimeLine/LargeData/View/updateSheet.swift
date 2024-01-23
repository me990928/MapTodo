//
//  updateSheet.swift
//  MapTodo
//
//  Created by 広瀬友哉 on 2024/01/23.
//

import SwiftUI

struct UpdateSheet: View {
    var body: some View {
            ScrollView{
            
                HStack{
                    Text("タイトル").bold()
                    Spacer()
                }.padding(.top)
                HStack{
                    TextField("タイトル", text: $title)
                    Spacer()
                }
                
                Divider()
                    
                HStack{
                    Text("サブタイトル").bold()
                    Spacer()
                }
                HStack{
                    TextField("サブタイトル", text: $subTitle)
                    Spacer()
                }
                
                Divider()
                
                HStack{
                    Text("住所").bold()
                    Spacer()
                }
                VStack{
                    HStack{
                        TextField("住所", text: $address)
                    }.onAppear(){
                        originalAddress = address
                    }
                }
                
                Divider()
                
                HStack{
                    Text("メモ").bold()
                    Spacer()
                }
                VStack{
                    HStack{
                        TextEditor(text: $memoData).frame(width: .infinity, height: 100)
                    }
                }
                    
                Divider()
                Button("完了"){
                    act { _ in
                        toolButton.toggle()
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                .interactiveDismissDisabled()
                .padding(.top)
                .onAppear(){
                    self.title = data.title
                    self.subTitle = data.subTitle
                    self.memoData = data.mapMemo
                }
                Spacer()
            }.padding([.trailing, .leading])
    }
}
