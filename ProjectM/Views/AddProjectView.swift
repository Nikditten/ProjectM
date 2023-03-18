//
//  AddProjectView.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct AddProjectView: View {
    
    @State var projectName: String = ""
    @State var projectHours: String = ""
    @State var deadline: Date = Date()
    
    var body: some View {
        
        VStack (spacing: 30) {
            
            Text("Opret et nyt projekt")
                .font(.title)
            
            CustomTextField(label: "Navn", value: $projectName)
            
            CustomTextField(label: "Timer", value: $projectHours, keyboardType: .decimalPad)
            
            DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
                .datePickerStyle(.compact)
            
            SubmitButton(
                label: "Opret projekt"
            ) {
                print("HELLO")
            }
            
            
        }
        .ignoresSafeArea(.keyboard, edges: [.bottom])
        .padding(.top, 50)
        .padding()
        .frame(
            width: UIScreen.screenWidth,
            height: UIScreen.screenHeight,
            alignment: .top
        )
        .background(Color.background)
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}
