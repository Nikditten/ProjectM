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
                    Color.progressBarBackground.opacity(0.5),
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
                    .foregroundColor(Color.white)
                    .font(.system(size: 14))
            } else {
                Text(Formatter.percent.string(from: NSNumber(value: progress))!)
                    .foregroundColor(Color.white)
                    .font(.system(size: 14))
                    .minimumScaleFactor(0.25)
            }
        }
        .frame(width: width, height: height)
    }
}
