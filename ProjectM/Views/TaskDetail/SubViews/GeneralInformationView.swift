//
//  GeneralInformationView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct GeneralInformationView: View {
    
    var title: String
    var hasDeadline: Bool
    var deadline: Date
    var hasEstimation: Bool
    var estimation: Double
    var color: Color
    
    init (task: Task) {
        self.title = task.title
        self.hasDeadline = task.hasDeadline
        self.deadline = task.deadline ?? Date()
        self.hasEstimation = task.hasEstimation
        self.estimation = task.estimation ?? 0.0
        self.color = task.color.toColor()
    }
    
    var body: some View {
        
        
        Text(title)
            .foregroundColor(Color.taskcardText)
            .font(.largeTitle)
            .fontWeight(.bold)
            .minimumScaleFactor(0.1)
            .truncationMode(.tail)
        
        Spacer().height(20)
        
        
        HStack {
            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "calendar")
                    Text(hasDeadline ? deadline.formatAsDate() : "No deadline")
                }
                HStack {
                    Image(systemName: "alarm")
                    Text(hasEstimation ? Formatter.hoursFull.string(from: estimation * 60 * 60)! : "No estimation")
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
            .foregroundColor(color)
        }
    }
}
