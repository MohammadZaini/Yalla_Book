//
//  DateHelper.swift
//  YallaBook
//
//  Created by Moe on 09/06/2024.
//

import UIKit

class DateHelper {
    
    static func formattedDateString(_ sender: UIDatePicker) -> String {
        let selectedDate = sender.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: selectedDate)
    }
    
    static func formattedDate(stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "d MMM yyyy 'at' h:mm a"
        
        guard let date = dateFormatter.date(from: stringDate) else {
            print("Invalid date format")
            return nil
        }
        
        return date
    }
    
    static func isDateOverlapping(targetDate: Date, startDate: Date, endDate: Date) -> Bool {
        
        if targetDate >= startDate && targetDate <= endDate {
            print("The target date is within the range.")
            return true
        } else {
            print("The target date is not within the range.")
            return false
        }
        
    }
    
    static func getNextDayOf(date: Date ) -> Date? {
        let today = Date()
        
        // Get the calendar
        var calendar = Calendar.current
        
        // Add one day to the current date
        if let nextDay = calendar.date(byAdding: .day, value: 1, to: date) {
            return nextDay
        }
        
        return nil
    }
}
