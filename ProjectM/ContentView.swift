//
//  ContentView.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var date: Date = Date.now

    var body: some View {
        VStack (alignment: .leading, spacing: 15) {
            DatepickerHeader(selectedDay: $date)
            
            Text("Dagens opgaver")
                .foregroundColor(Color.text)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        ForEach(1..<12) { value in
                            TaskCard()
                            
                            if (value != 11) {
                                Divider()
                                    .frame(height: 2)
                                    .background(Color.header)
                                
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
        .background(Color.background)
            
    }


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
