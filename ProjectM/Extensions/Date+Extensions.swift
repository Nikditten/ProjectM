//
//  Date+Extensions.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import Foundation

extension Date {
    
    func asDay() -> Int {
        return Calendar.current.dateComponents([.day, .month, .year], from: self).day ?? -1
    }
    
    func asYear() -> Int {
        return Calendar.current.dateComponents([.day, .month, .year], from: self).year ?? -1
    }
    
    func nameOfMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return  dateFormatter.string(from: self)
    }
    
    func nameOfDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ccc"
        return  dateFormatter.string(from: self)
    }
    
    func daysInMonth() -> [Date] {
            let cal = Calendar.current
        
            let monthRange = cal.range(of: .day, in: .month, for: self)!
            let comps = cal.dateComponents([.year, .month], from: self)
        
            var date = cal.date(from: comps)!

            var dates: [Date] = []
        
            for _ in monthRange {
                
                dates.append(date)
                
                date = cal.date(byAdding: .day, value: 1, to: date)!
            }
            return dates
    }
}
