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
    
    // init viewmodel with task as parameter
    init(taskId: UUID) {
        self.vm = TaskDetailViewModel(taskId: taskId)
    }
    
    @State private var progress = 0.2
    
    var body: some View {
        VStack {
            
            VStack (alignment: .leading) {
                
                Text(vm.task.name!)
                    .foregroundColor(Color.taskcardText)
                    .font(vm.task.name!.count > 25 ? .title : .largeTitle)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.1)
                    .truncationMode(.tail)
                    .padding([.top, .bottom])
                
                
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "alarm")
                            Text(vm.task.estimation != 0.0 ? Formatter.hoursFull.string(from: vm.task.estimation * 60 * 60)! : "No estimation")
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
                    .foregroundColor(ProjectColors(rawValue: vm.task.color!)!.toColor())
                    
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
                            .font(.headline)
                            .foregroundColor(Color.text)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                completed.toggle()
                            }
                        } label: {
                            Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(ProjectColors(rawValue: vm.task.color!)?.toColor())
                                .accessibility(label: Text(completed ? "Checked" : "Unchecked"))
                                .imageScale(.large)
                        }
                        .font(.title3)
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    ProgressView(value: 0.2, total: 1)
                        .tint(ProjectColors(rawValue: vm.task.color!)?.toColor())
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding(.bottom)
                    
                    if (vm.task.note != nil && vm.task.note?.count ?? 0 > 0) {

                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.text)
                            .padding(.bottom, 5)
                            .padding(.top)
                        
                        ExpandableText(vm.task.note!, color: (ProjectColors(rawValue: vm.task.color!)?.toColor())!)
                            .padding(.bottom)
                    }
                    
                    HStack {
                        Text("Sub task")
                            .foregroundColor(Color.text)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        
                        Spacer()
                        
                        if (vm.task.subtasks?.count ?? 0 > 0) {
                            Button {
                                withAnimation {
                                    vm.showInputField.toggle()
                                }
                            } label: {
                                Image(systemName: vm.showInputField ?  "xmark.circle": "plus.circle")
                                    .foregroundColor(ProjectColors(rawValue: vm.task.color!)?.toColor())
                            }
                        }
                    }
                    .font(.title2)
                    
                    ScrollView {
                        VStack{
                            if let subtasks = vm.task.subtasks?.allObjects as? [SubTask] {
                                ForEach(subtasks, id: \.self) { subtask in
                                    SubTaskCard(projectColor: (ProjectColors(rawValue: vm.task.color!)?.toColor())!, _subtask: subtask)
                                }}
                            
                            if (vm.showInputField) {
                                TextField("New subtask", text: $vm.value)
                                    .keyboardType(.default)
                                    .padding(15)
                                    .padding(.trailing, 30)
                                    .background(Color.textfield_background)
                                    .cornerRadius(10)
                                    .foregroundColor(.text)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        vm.add()
                                    }
                            }
                            
                            if (vm.task.subtasks?.count ?? 0 == 0) {
                                Button {
                                    withAnimation {
                                        vm.showInputField.toggle()
                                    }
                                } label: {
                                    Image(systemName: vm.showInputField ? "xmark" : "plus")
                                        .foregroundColor(Color.taskDetailAddSubTask)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding()
                                        .cornerRadius(10)
                                }
                                .frame(maxWidth: .infinity)
                                .background(ProjectColors(rawValue: vm.task.color!)?.toColor())
                                .cornerRadius(10)
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
                    print("EDIT")
                    
                } label: {
                    Image(systemName: "highlighter")
                    
                }
                .font(.title3)
                .foregroundColor(Color.taskDetailIcon)
            }
        }
    }
}

