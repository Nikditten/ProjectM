//
//  ContentView.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showingSheet: Bool = false
    
    @StateObject var vm: TaskOverviewModel = TaskOverviewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 15) {
                    ForEach(vm.tasks) { task in
                        NavigationLink () {
                            TaskDetailView(task: task)
                        } label: {
                            TaskCard(task: task)
                        }
                        .contextMenu {
                            Button(action: {
                                withAnimation {
                                    vm.toggleState(task: task)
                                }
                            }, label: {
                                Text(!task.completed ? "Mark as completed" : "Unmark as completed")
                                Image(systemName: !task.completed ? "checkmark.circle.fill" : "circle")
                                    .accessibility(label: Text(!task.completed ? "Checked" : "Unchecked"))
                                    .imageScale(.large)
                            })
                            
                            Button(action: {
                                withAnimation {
                                    vm.taskToEdit = task
                                    showingSheet = true
                                }
                            }, label: {
                                Text("Edit")
                                Image(systemName: "highlighter")
                                    .accessibility(label: Text("Edit"))
                                    .imageScale(.large)
                            })
                            
                            Button(action: {
                                withAnimation {
                                    vm.deleteTask(task: task)
                                }
                            }, label: {
                                Text("Delete")
                                Image(systemName: "trash")
                                    .accessibility(label: Text("Delete"))
                                    .imageScale(.large)
                            })
                        }
                    }
                }
            }
            .frame(alignment: .top)
            .padding([.leading, .trailing])
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.iconColor)
                    })
                }
            }
        }
        .background(Color.background)
        .sheet(isPresented: $showingSheet, onDismiss: {vm.taskToEdit = nil}) {
            AddProjectSheet(task: vm.taskToEdit, isPresented: $showingSheet)
        }
        .onAppear {
            withAnimation{
                vm.fetchTasks()
            }
        }
        
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
