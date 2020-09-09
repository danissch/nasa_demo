//
//  DateExtension.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 6/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation

extension Date {
    static func getDates(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        
        // start with today
        //var date = cal.startOfDay(for: Date())
        var date = cal.date(byAdding: .day, value: 1, to: Date())

        var arrDates = [String]()

        for _ in 1 ... nDays {
            // move back in time by one day:
            
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date ?? Date())!

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date ?? Date())
            arrDates.append(dateString)
        }
        //print(arrDates)
        return arrDates
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    
}
