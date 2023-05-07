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
    
    @StateObject var vm: ProjectOverviewModel = ProjectOverviewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack (spacing: 15) {
                    ForEach(vm.projects) { project in
                        NavigationLink () {
                            ProjectDetailView(project: project)
                        } label: {
                            ProjectCard(project: project)
                        }
                    }
                }
            }
            .frame(alignment: .top)
            .padding([.leading, .trailing])
            .navigationTitle("Projects")
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
        .sheet(isPresented: $showingSheet, onDismiss: {vm.projectToEdit = nil}) {
            AddProjectSheet(project: vm.projectToEdit, isPresented: $showingSheet)
        }
        .onAppear {
            withAnimation{
                vm.fetchProjects()
            }
        }
        
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
