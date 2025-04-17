//
//  date+EXT.swift
//  GHFollowers
//
//  Created by Begench on 16.04.2025.
//

import Foundation

extension String {
    func ConverToDate() -> Date? {
        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateformater.locale = Locale(identifier: "en_US_POSIX")
        dateformater.timeZone = .current
        
        
        return dateformater.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.ConverToDate() else { return "N/A"}
        return date.convertToMonthYearFormat()
    }
}




extension Date {
    func convertToMonthYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
