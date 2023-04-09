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
    
    init(task: Task?, isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.vm = AddProjectViewModel(task: task)
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 25) {
                    
                    CustomTextField(label: "Name", value: $vm.edititingTask.title)
                    
                    MultilineTextField(label: "Description", value: $vm.edititingTask.description.toUnwrapped(defaultValue: ""), linelimit: 3)
                    
                    DatePickerField(label: "Deadline", color: vm.edititingTask.color.toColor(), value: $vm.edititingTask.deadline.toUnwrapped(defaultValue: Date()), hasDay: $vm.hasDeadline)
                    
                    HourPickerField(label: "Estimated hours", color: vm.edititingTask.color.toColor(), value: $vm.edititingTask.estimation.toUnwrapped(defaultValue: 0.0), showHours: $vm.hasEstimation)

                    ColorPickerField(label: "Color", activeColor: $vm.edititingTask.color)
                    
                    SubmitButton(
                        label: vm.editMode ? "Update" : "Create",
                        color: vm.edititingTask.color.toColor()
                    ) {
                        
                        isPresented = !vm.submit()
                    }
                    .disabled(vm.edititingTask.title.count == 0)
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
