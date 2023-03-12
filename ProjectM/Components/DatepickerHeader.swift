//
//  DatepickerHeader.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import SwiftUI

struct DatepickerHeader: View {
    
    @Binding var selectedDay: Date
    
    var body: some View {
        VStack (alignment: .center, spacing: 25) {
            HStack {
                Image(systemName: "calendar")

                Text(selectedDay.nameOfMonth() + ", " + String(selectedDay.asYear()))
                
            }
            .font(.system(size: 30))
            .foregroundColor(Color.text)
            .onTapGesture {
                
            }
            
                ScrollViewReader {value in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
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
                .padding(.horizontal, 20)
        }
        .padding(.top, 10)
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.33, alignment: .center)
        .background(Color.header)
        .roundedCorner(30, corners: [.bottomLeft, .bottomRight])
        .ignoresSafeArea()
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

// MARK: - Preview

struct DatepickerHeader_PreviewContainer : View {
     @State
    private var value = Date.now

     var body: some View {
         VStack {
             DatepickerHeader(selectedDay: $value)
         }
         .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
         .background(Color.background)
     }
}

struct DatepickerHeader_Previews: PreviewProvider {
    static var previews: some View {
        DatepickerHeader_PreviewContainer()
    }
}
