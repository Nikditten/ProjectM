//
//  AddProjectView.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct AddProjectSheet: View {
    
    @Binding var isPresented: Bool
    
    @ObservedObject var vm: AddProjectViewModel = AddProjectViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 25) {
                    
                    CustomTextField(label: "Name", value: $vm.projectName)
                    
                    MultilineTextField(label: "Description", value: $vm.projectNote, linelimit: 3)
                    
                    DatePickerField(label: "Deadline", value: $vm.projectDeadline, hasDay: $vm.hasDeadline)
                    
                    HourPickerField(label: "Estimated hours", value: $vm.projectHours, showHours: $vm.hasEstimation)

                    ColorPickerField(label: "Color", activeColor: $vm.projectColor)
                    
                    SubmitButton(
                        label: "Create"
                    ) {
                        
                        isPresented = !vm.add()
                    }
                    .disabled(vm.projectName.count == 0)
                    .padding(.bottom, 40)
                    
                    
                }
            }
            .padding()
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
