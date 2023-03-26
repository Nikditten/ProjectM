//
//  TaskDetailView.swift
//  ProjectM
//
//  Created by Niklas Børner on 26/03/2023.
//

import SwiftUI

struct TaskDetailView: View {
    
    //let task: Task
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 5) {
                
                HStack {
                    Button {
                        dismiss()
                        
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            
                    }
                }
                .font(.title2)
                .foregroundColor(Color.background)
                
                Text("This is a title")
                    .foregroundColor(Color.taskcardText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .padding([.top, .bottom])
                
                
                
                HStack {
                    Image(systemName: "alarm")
                    Text("4 hours")
                }
                .foregroundColor(Color.taskcardText.opacity(0.75))
                .font(.headline)
                
                HStack {
                    Image(systemName: "calendar")
                    Text("26-10-2023")
                }
                .foregroundColor(Color.taskcardText.opacity(0.75))
                .font(.headline)
                
            }
            .padding()
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.30, alignment: .leading)
            
            VStack {
                Text("Hello")
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.70)
            .background(Color.background)
            .roundedCorner(30, corners: [.topLeft, .topRight])
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom)
        .background(ProjectColors.green.toColor())
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TaskDetailView()
        }
    }
}
