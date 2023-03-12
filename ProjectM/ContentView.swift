//
//  ContentView.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        VStack {
            DatepickerHeader()
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom)
        .background(Color.background)
    }


}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
