//
//  ContentView.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showingSheet: Bool = true
    
    var body: some View {
        
        NavigationView {
            Text("HELLO WORLD!")
                .onTapGesture {
                    showingSheet = true
                }
        }
        .sheet(isPresented: $showingSheet) {
            AddProjectSheet(isPresented: $showingSheet)
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
