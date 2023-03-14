//
//  TaskHeader.swift
//  ProjectM
//
//  Created by Niklas Børner on 14/03/2023.
//

import SwiftUI

struct TaskHeader: View {
    var body: some View {
        VStack (alignment: .leading) {
            
            HStack {
                Text("This is a task")
                    .font(.system(size: 24))
                
                Spacer()
                
                Image(systemName: "pencil")
            }
            .foregroundColor(Color.text)
            
            
            Text("Deadline")
                .foregroundColor(Color.text)
                .padding(.top, 10)
            
            HStack {
                Image(systemName: "alarm")
                Text("10:00 - 11:00")
                
                Image(systemName: "calendar")
                Text("21. februar")
            }
            .foregroundColor(Color.text.opacity(0.5))
            .font(.system(size: 20))
            .fontWeight(.bold)
            
        }
        .padding(20)
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.33, alignment: .bottom)
        .background(Color.secondary_header)
        .roundedCorner(30, corners: [.bottomLeft, .bottomRight])
        .ignoresSafeArea()
    }
}

struct TaskHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TaskHeader()
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
        .background(Color.background)
    }
}
