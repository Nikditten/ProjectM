//
//  AddProjectView.swift
//  ProjectM
//
//  Created by Niklas Børner on 18/03/2023.
//

import SwiftUI

struct AddProjectSheet: View {
    
    @Binding var isPresented: Bool
    
    @ObservedObject var vm: AddProjectViewModel
    
    init(project: Project?, isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.vm = AddProjectViewModel(project: project)
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 25) {
                    
                    CustomTextField(label: "Name", value: $vm.editingProject.title)
                    
                    MultilineTextField(label: "Description", value: $vm.editingProject.description.toUnwrapped(defaultValue: ""), linelimit: 3)
                    
                    DatePickerField(label: "Deadline", color: vm.editingProject.color.toColor(), value: $vm.editingProject.deadline.toUnwrapped(defaultValue: Date()), hasDay: $vm.hasDeadline)
                    
                    HourPickerField(label: "Estimated hours", color: vm.editingProject.color.toColor(), value: $vm.editingProject.estimation.toUnwrapped(defaultValue: 0.0), showHours: $vm.hasEstimation)
                    
                    ColorPickerField(label: "Color", activeColor: $vm.editingProject.color)
                    
                    SubmitButton(
                        label: vm.editMode ? "Update" : "Create",
                        color: vm.editingProject.color.toColor()
                    ) {
                        
                        isPresented = !vm.submit()
                    }
                    .disabled(vm.editingProject.title.count == 0)
                    
                    if (vm.editMode) {
                        
                        Button(action: {
                            vm.delete()
                            isPresented = false
                        }, label: {
                            Text("Delete")
                                .foregroundColor(Color.destructive)
                        })
                        .font(.title3)
                        
                    }
                    
                    Spacer(minLength: 40)
                    
                    
                }
            }
            .padding()
            .background(Color.background)
            .ignoresSafeArea(.container, edges: [.bottom])
            .navigationTitle("New project")
        }
    }
}
