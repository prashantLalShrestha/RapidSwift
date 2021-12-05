//
//  Date++.swift
//

import Foundation

public extension Date {
    var dateExcludingTime: Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let day = Calendar.current.date(from: dateComponents)!
        return day
    }
    
    /// convert Date to UTC time zone string in provided format
    /// - Parameter format: format string
    /// - Returns: Date as string in the form of provided format at UTC time zone
    func toUTCString(format: String) -> String {
        let dateFormatter = Date.dateFormatter(timeZone: TimeZone.UTCTimeZone, locale: Locale.enUSPosix, dateFormat: format)
        return dateFormatter.string(from: self)
    }
    
    /// convert Date to Device current time zone string in provided format
    /// - Parameter format: format string
    /// - Returns: Date as string in the form of provided format at device's local time zone
    func toLocalTimeZoneString(format: String) -> String {
        let dateFormatter = Date.dateFormatter(timeZone: TimeZone.current, locale: Locale.enUSPosix, dateFormat: format)
        return dateFormatter.string(from: self)
    }
    
    /// returns date formatter with given parameter
    /// - Parameters:
    ///   - timeZone: timeZone
    ///   - locale: locale
    ///   - dateFormat: String with date format
    /// - Returns: dateFormatter
    static func dateFormatter(timeZone: TimeZone? = nil, locale: Locale? = nil, dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        
        // set time zone
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        
        // set locale
        if let locale = locale {
            dateFormatter.locale = locale
        }
        
        // set date format
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}


fileprivate extension Locale {
    /// en_US_POSIX locale
    static var enUSPosix: Locale { return Locale(identifier: "en_US_POSIX") }
}

fileprivate extension TimeZone {
    
    /// UTC Time zone
    static var UTCTimeZone: TimeZone? = { return TimeZone(abbreviation: "UTC") }()
}
