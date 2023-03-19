//
//  CircularProgressBar.swift
//  ProjectM
//
//  Created by Niklas Børner on 19/03/2023.
//

import SwiftUI

struct CircularProgressBar: View {
    let progress: Double

        let height: CGFloat = 60
        let width: CGFloat = 60
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(
                        Color.progressBar,
                        lineWidth: 5
                    )
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.white,
                        style: StrokeStyle(
                            lineWidth: 5,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
                
                Text("80%")
                    .foregroundColor(Color.text)
            }
            .frame(width: width, height: height)
        }
    }
