//
//  ExpandableText.swift
//  ProjectM
//
//  Created by Niklas Børner on 01/04/2023.
//

import Foundation
import SwiftUI

struct ExpandableText: View {
    
    @State private var expanded: Bool = false
    
    @State private var truncated: Bool = false
    
    private var text: String
    private var color: Color
    
    var lineLimit = 3
    
    init(_ text: String, color: Color) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(text)
                .lineLimit(expanded ? nil : lineLimit)
                .foregroundColor(Color.text)
            
                .background(
                    
                    Text(text).lineLimit(lineLimit)
                        .background(GeometryReader { displayedGeometry in
                            
                            ZStack {
                                
                                Text(self.text)
                                    .background(GeometryReader { fullGeometry in
                                        
                                        Color.clear.onAppear {
                                            self.truncated = fullGeometry.size.height > displayedGeometry.size.height
                                        }
                                    })
                            }
                            .frame(height: .greatestFiniteMagnitude)
                        })
                        .hidden()
                )
            
            if truncated {
                toggleButton
            }
        }
    }
    
    var toggleButton: some View {
        Button {
            withAnimation {
                self.expanded.toggle()
            }
            
        } label: {
            Image(systemName: expanded ? "chevron.up" : "chevron.down")
        }
        .padding(.top, 1)
        .font(.footnote)
        .fontWeight(.bold)
        .foregroundColor(color)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
