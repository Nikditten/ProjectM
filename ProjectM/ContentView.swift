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
        VStack {
            DatepickerHeader(selectedDay: $date)
                .padding()
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
