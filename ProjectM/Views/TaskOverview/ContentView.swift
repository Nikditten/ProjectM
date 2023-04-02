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
    
    @ObservedObject var vm: TaskOverviewModel = TaskOverviewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 15) {
                    ForEach(vm.tasks) { task in
                        NavigationLink () {
                            TaskDetailView(taskId: task.id!)
                        } label: {
                            TaskCard(task: task)
                        }
                    }
                    .onAppear {
                        vm.refreshTasks()
                    }
                }
            }
            .frame(alignment: .top)
            .padding([.leading, .trailing])
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
        .sheet(isPresented: $showingSheet, onDismiss: vm.refreshTasks) {
            AddProjectSheet(taskId: nil, isPresented: $showingSheet)
        }
        
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
