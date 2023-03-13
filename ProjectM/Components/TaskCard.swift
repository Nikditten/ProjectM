//
//  TaskCard.swift
//  ProjectM
//
//  Created by Niklas Børner on 13/03/2023.
//

import SwiftUI

struct TaskCard: View {
    var body: some View {
        HStack {
            Text("10:00")
                .foregroundColor(Color.text.opacity(0.5))
                .padding(.trailing, 20)
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 5) {
                  Text("Landing page design")
                        .foregroundColor(Color.text)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: "alarm")
                        Text("10:00 - 11:00")
                    }
                    .foregroundColor(Color.text.opacity(0.5))
                    .font(.system(size: 15))
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("21. februar")
                    }
                    .foregroundColor(Color.text.opacity(0.5))
                    .font(.system(size: 15))
                    
                }
                Spacer()
                CircularProgressBar(progress: 0.23)
            }
            .padding(10)
            .background(Color.card_background)
            .clipShape(RoundedCorner(radius: 10))
        }
    }
}

struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard()
    }
}
