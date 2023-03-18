//
//  AddProjectView.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct AddProjectView: View {
    
    @State var projectName: String = ""
    @State var projectDeadline: Date = Date()
    @State var projectHours: Double = 1.0
    @State var note: String = ""
    
    @State var showDate: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack (spacing: 25) {
                
                Text("New Task")
                    .font(.largeTitle)
                
                CustomTextField(label: "Name", value: $projectName)
                
                MultilineTextField(label: "Description", value: $note, linelimit: 3)
                
                DatePickerField(label: "Deadline", value: $projectDeadline)
                
                HourPickerField(label: "Estimated hours", value: $projectHours)

                
                SubmitButton(
                    label: "Done"
                ) {
                    print("HELLO")
                }
                
                
            }
        }
        .padding()
        .padding(.bottom, 40)
        .background(Color.background)
        .ignoresSafeArea(.container, edges: [.bottom])
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView()
    }
}
