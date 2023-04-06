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
    
    @State var completed = false
    
    init(task: Task, dataSource: DataSource = DataSource.shared) {
        self.vm = TaskDetailViewModel(task: task, dataSource: dataSource)
    }
    
    @State private var progress = 0.2
    
    var body: some View {
        VStack {
            
            VStack (alignment: .leading) {
                
                Text(vm.task.title)
                    .foregroundColor(Color.taskcardText)
                    .font(vm.task.title.count > 25 ? .title : .largeTitle)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.1)
                    .truncationMode(.tail)
                    .padding([.top, .bottom])
                
                
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "alarm")
                            Text(vm.task.estimation != 0.0 ? Formatter.hoursFull.string(from: (vm.task.estimation ?? 0) * 60 * 60)! : "No estimation")
                        }
                        
                        
                        HStack {
                            Image(systemName: "calendar")
                            Text(vm.task.deadline != nil ? vm.task.deadline!.formatAsDate() : "No deadline")
                        }
                    }
                    .foregroundColor(Color.taskcardText.opacity(0.75))
                    .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            print("TIMETRACKING")
                        }
                        
                    } label: {
                        Image(systemName: "play.circle.fill")
                        
                    }
                    .font(.largeTitle)
                    .foregroundColor(vm.task.color.toColor())
                    
                }
                
            }
            .padding([.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            ScrollView {
                VStack (alignment: .leading) {
                    
                    Text("Progression")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.text)
                        .padding(.bottom, 5)
                        .padding(.top)
                    
                    HStack (alignment: .center) {
                        
                        Text(completed ? "Completed" : "Ongoing")
                            .foregroundColor(Color.text)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                completed.toggle()
                            }
                        } label: {
                            Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(vm.task.color.toColor())
                                .accessibility(label: Text(completed ? "Checked" : "Unchecked"))
                                .imageScale(.large)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .font(.headline)
                    
                    ProgressView(value: 0.2, total: 1)
                        .tint(vm.task.color.toColor())
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding(.bottom)
                    
                    if (vm.task.description != nil && vm.task.description?.count ?? 0 > 0) {

                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.text)
                            .padding(.bottom, 5)
                            .padding(.top)
                        
                        ExpandableText(vm.task.description!, color: vm.task.color.toColor())
                            .padding(.bottom)
                    }
                    
                    HStack {
                        Text("Sub task")
                            .foregroundColor(Color.text)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                vm.showInputField.toggle()
                            }
                        } label: {
                            Image(systemName: vm.showInputField ?  "xmark.circle": "plus.circle")
                                .foregroundColor(vm.task.color.toColor())
                        }
                    }
                    .font(.title2)
                    .padding(.bottom, 5)
                    
                    ScrollView {
                        VStack{
                            if (vm.showInputField) {
                                HStack {
                                    Button {
                                        withAnimation {
                                            completed.toggle()
                                        }
                                    } label: {
                                        Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(vm.task.color.toColor())
                                            .accessibility(label: Text(completed ? "Checked" : "Unchecked"))
                                            .imageScale(.large)
                                    }
                                    .font(.headline)
                                    .frame(alignment: .topLeading)
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    TextField("New subtask", text: $vm.newSubTask.title)
                                        .keyboardType(.default)
                                        .cornerRadius(10)
                                        .foregroundColor(Color.subTaskCardText)
                                        .submitLabel(.done)
                                        .onSubmit {
                                            vm.add()
                                        }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.subTaskCardBackground)
                                .cornerRadius(10)
                            }
                            
                            ForEach(vm.task.subtasks, id: \.self) { subtaskId in
                                    SubTaskCard(
                                        subtaskId: subtaskId, color: vm.task.color
                                    )
                                }
                            
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding()
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.65, alignment: .bottom)
            .background(Color.taskDetailBodyBackground)
            .roundedCorner(30, corners: [.topLeft, .topRight])
            
        }
        .background(Color.taskDetailHeaderBackground)
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

