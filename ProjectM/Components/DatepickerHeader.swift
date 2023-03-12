//
//  DatepickerHeader.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import SwiftUI

struct DatepickerHeader: View {
    
    @State var selectedDay: Date = Date.now
    
    var body: some View {
        VStack (spacing: 25) {
            HStack {
                Image(systemName: "calendar")

                Text("May, 2022")
            }
            .font(.system(size: 30))
            .foregroundColor(Color.text)
            

                ScrollViewReader {value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(selectedDay.daysInMonth(), id: \.self) { date in
                                DayItem(date, selected: date.asDay() == selectedDay.asDay())
                                    .id(date.asDay())
                                    .onTapGesture {
                                        withAnimation {
                                            selectedDay = date
                                            value.scrollTo(selectedDay.asDay(), anchor: .center)
                                        }
                                    }
                            }
                            
                        }

                    }
                    .onAppear {
                        value.scrollTo(selectedDay.asDay(), anchor: .center)
                    }
                }
                .scaleEffect()
                .padding(.horizontal, 20)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.33, alignment: .center)
        .background(Color.header)
        .roundedCorner(30, corners: [.topLeft, .topRight])
    }
}

func DayItem(_ date: Date, selected: Bool) -> some View {
    VStack {
        Text(String(date.asDay()))
            .font(.system(size: 56))
            .fontWeight(.bold)
        
        Text(date.nameOfDay())
            .font(.system(size: 24))
    }
    .foregroundColor(selected ? Color.text : Color.text.opacity(0.6))
}

struct DatepickerHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DatepickerHeader()
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom)
        .background(Color.background)
        
    }
}
