//
//  AddProjectView.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct AddProjectSheet: View {
    
    @Binding var isPresented: Bool
    
    @State var projectName: String = ""
    @State var projectDeadline: Date = Date()
    @State var projectHours: Double = 1.0
    @State var note: String = ""
    
    @State var hasDeadline: Bool = false
    @State var hasEstimation: Bool = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 25) {
                    
                    CustomTextField(label: "Name", value: $projectName)
                    
                    MultilineTextField(label: "Description", value: $note, linelimit: 3)
                    
                    DatePickerField(label: "Deadline", value: $projectDeadline, hasDay: $hasDeadline)
                    
                    HourPickerField(label: "Estimated hours", value: $projectHours, showHours: $hasEstimation)

                    // Custom radiobuttons to select color
                    ColorPickerField(label: "Color")
                    
                    
                    SubmitButton(
                        label: "Done"
                    ) {
                        isPresented = false
                    }
                    
                    
                }
            }
            .padding()
            .padding(.bottom, 40)
            .background(Color.background)
            .ignoresSafeArea(.container, edges: [.bottom])
            .navigationTitle("New Task")
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectSheet(isPresented: .constant(true))
    }
}
