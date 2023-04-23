//
//  SmallCardView.swift
//  ProjectM
//
//  Created by Niklas Børner on 22/04/2023.
//

import SwiftUI

struct SmallCardView: View {
    
    var image: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Spacer()
                Image(systemName: image)
                    .font(.title2)
            }
            
            Spacer().height(20)
            
            Text(text)
                .font(.headline)
        }
        .padding()
        .background(Color.taskDetailCardBackground)
        .cornerRadius(10)
    }
}

struct SmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardView(image: "calendar", text: "28. april 2023")
    }
}
