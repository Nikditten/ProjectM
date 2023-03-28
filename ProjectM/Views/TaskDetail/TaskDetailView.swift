//
//  TaskDetailView.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import SwiftUI

struct subtask: Hashable {
    var name: String
    var note: String
    var state: TaskState
    
    init(name: String, note: String, state: TaskState) {
        self.name = name
        self.note = note
        self.state = state
    }
}

struct TaskDetailView: View {
    
    let task: Task
    
    @Environment(\.dismiss) private var dismiss
    
    @State var showFullDescription = false
    @State var showInputField = false
    @State var value = ""
    
    
    
    var body: some View {
        VStack {
            
            VStack (alignment: .leading) {
                
                Text(task.name!)
                    .foregroundColor(Color.taskcardText)
                    .font(task.name!.count > 25 ? .title : .largeTitle)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.1)
                    .truncationMode(.tail)
                    .padding([.top, .bottom])
                
                
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        HStack {
                            Image(systemName: "alarm")
                            Text(task.estimation != 0.0 ? String(task.estimation) + " hours" : "No estimation")
                        }
                        
                        
                        HStack {
                            Image(systemName: "calendar")
                            Text(task.deadline != nil ? task.deadline!.formatAsDate() : "No deadline")
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
                    .foregroundColor(Color.background)
                    
                }
                
            }
            .padding([.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color.text)
                        .padding(.bottom, 5)
                        .padding(.top)
                    if (task.note != nil && task.note?.count ?? 0 > 0) {
                        
                        VStack {
                            Text(task.note!)
                                .lineLimit(showFullDescription ? .max : 4)
                                .truncationMode(.tail)
                                .foregroundColor(Color.text)
                            
                            Button {
                                withAnimation {
                                    showFullDescription.toggle()
                                }
                                
                            } label: {
                                HStack {
                                    Text("See full description")
                                    Image(systemName: showFullDescription ? "chevron.up" : "chevron.down")
                                }
                                
                            }
                            .padding(.top, 2)
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(ProjectColors(rawValue: task.color!)?.toColor())
                            
                        }
                        .padding(.bottom)
                    }
                    
                    Text("Sub task")
                        .foregroundColor(Color.text)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    ScrollView {
                        VStack{
                            if let subtasks = task.subtasks?.allObjects as? [SubTask] {
                                ForEach(subtasks, id: \.self) { subtask in
                                    SubTaskCard(_subtask: subtask)
                                }}
                            
                            Button {
                                withAnimation {
                                    showInputField.toggle()
                                }
                            } label: {
                                Image(systemName: showInputField ? "xmark" : "plus")
                                    .foregroundColor(ProjectColors(rawValue: task.color!)?.toColor())
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(ProjectColors(rawValue: task.color!)!.toColor(), lineWidth: 4)
                                    )
                            }
                            .background(Color.background)
                            .cornerRadius(10)
                            
                            if (showInputField) {
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                TextField("New subtask", text: $value)
                                    .keyboardType(.default)
                                    .padding(15)
                                    .padding(.trailing, 30)
                                    .background(Color.textfield_background)
                                    .cornerRadius(10)
                                    .foregroundColor(.text)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .padding()
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.65, alignment: .bottom)
            .background(Color.background)
            .roundedCorner(30, corners: [.topLeft, .topRight])
            
        }
        .background(ProjectColors(rawValue: task.color!)!.toColor())
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
                .foregroundColor(Color.background)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("EDIT")
                    
                } label: {
                    Image(systemName: "highlighter")
                    
                }
                .font(.title3)
                .foregroundColor(Color.background)
            }
        }
    }
}

