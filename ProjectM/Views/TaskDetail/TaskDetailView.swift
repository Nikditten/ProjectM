//
//  TaskDetailView.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var vm: TaskDetailViewModel
    
    init(task: Task, dataSource: DataSource = DataSource.shared) {
        self.vm = TaskDetailViewModel(task: task, dataSource: dataSource)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            
            GeneralInformationView(task: vm.task)
            
            Spacer().height(40)
            
            ProgressionView(color: vm.task.color, markAsCompleted: vm.markAsCompleted, progression: vm.progression) {
                withAnimation {
                    vm.toggleState()
                }
            }
            
            Spacer().height(40)
            
            if (vm.task.hasDescription) {
                DescriptionView(description: vm.task.description!, color: vm.task.color.toColor())
                
                Spacer().height(40)
            }
            
            SubtaskContainerView(newSubTaskTitle: $vm.newSubTask.title, showInputField: $vm.showInputField, color: vm.task.color.toColor(), subtasks: vm.task.subtasks) {
                withAnimation {
                    vm.add()
                }
            }
            
            Spacer(minLength: 40)
        }
        .padding()
        .background(Color.taskDetailBodyBackground)
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .font(.title3)
                .foregroundColor(Color.taskDetailIcon)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.showEditSheet.toggle()
                } label: {
                    Image(systemName: "highlighter")
                    
                }
                .font(.title3)
                .foregroundColor(Color.taskDetailIcon)
            }
        }
        .sheet(isPresented: $vm.showEditSheet) {
            AddProjectSheet(task: vm.task, isPresented: $vm.showEditSheet)
        }
    }
}
