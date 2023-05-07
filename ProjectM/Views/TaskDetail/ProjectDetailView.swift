//
//  TaskDetailView.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import SwiftUI

struct ProjectDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var vm: ProejctDetailViewModel
    
    init(project: Project, dataSource: DataSource = DataSource.shared) {
        self.vm = ProejctDetailViewModel(project: project, dataSource: dataSource)
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                
                HStack {
                    Button {
                        dismiss()

                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .font(.title3)
                    .foregroundColor(Color.taskcardText)
                    
                    Spacer()
                    
                    Button {
                        vm.showEditSheet.toggle()
                    } label: {
                        Image(systemName: "highlighter")

                    }
                    .font(.title3)
                    .foregroundColor(Color.taskcardText)
                }
                .padding([.top, .horizontal])
                
                GeneralInformationView(project: vm.project)
                
                Spacer().height(40)
                
                ProgressionView(project: vm.project, markAsCompleted: vm.markAsCompleted, progression: vm.progression) {
                    withAnimation {
                        vm.toggleState()
                    }
                }
                
                Spacer().height(.projectOverviewSpacing)
                
                TaskContainerView(newTaskTitle: $vm.newTask.title, showInputField: $vm.showInputField, color: vm.project.color.toColor(), tasks: vm.project.tasks) {
                    withAnimation {
                        vm.add()
                    }
                }
                
                Spacer(minLength: .projectOverviewSpacing)
                
                
            }
        }
        .background(Color.taskDetailBackground)
        .frame(alignment: .bottom)
        .ignoresSafeArea(.all, edges: .bottom)
        .toolbar(.hidden)
        .sheet(isPresented: $vm.showEditSheet) {
            AddProjectSheet(project: vm.project, isPresented: $vm.showEditSheet)
        }
    }
}
