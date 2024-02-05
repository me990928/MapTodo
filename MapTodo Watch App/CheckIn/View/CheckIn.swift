//
//  CheckIn.swift
//  MapTodo Watch App
//
//  Created by 広瀬友哉 on 2024/01/29.
//

import SwiftUI

struct CheckIn: View {
    
    @StateObject var checkInVM = CheckInViewModel()
    
    var body: some View {
        Button(action: {
            checkInVM.model.flag.toggle()
            checkInVM.model.model.endDate = Date()
            checkInVM.model.model.registDate = Date()
            checkInVM.setLocation(){
                checkInVM.model.flag.toggle()
            }
        }, label: {
            checkInVM.model.flag ? Text("Check Now...") : Text("CheckIN!")
            
        })
    }
}

#Preview {
    CheckIn()
}
