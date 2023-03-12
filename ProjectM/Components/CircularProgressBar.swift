//
//  CircularProgressBar.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import SwiftUI

struct CircularProgressView: View {
    
    let progress: Double

    let height: CGFloat = 50
    let width: CGFloat = 50
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.header,
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


struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CircularProgressView(progress: 0.54)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(Color.background)
    }
}
