//
//  CircularProgressBar.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct CircularProgressBar: View {
    
    let color: Color
    let progress: Double
    
    let height: CGFloat = 50
    let width: CGFloat = 50
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.progressBarBackground,
                    lineWidth: 5
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            if (progress == 1) {
                Image(systemName: "checkmark")
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .fontWeight(.black)
            } else {
                Text(Formatter.percent.string(from: NSNumber(value: progress))!)
                    .foregroundColor(Color.progressBarText)
                    .font(.system(size: 14))
                    .minimumScaleFactor(0.25)
            }
        }
        .frame(width: width, height: height)
    }
}
