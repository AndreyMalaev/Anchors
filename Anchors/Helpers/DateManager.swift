//
//  DateManager.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/23/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import Foundation

class DateManager {
    
    fileprivate static func dateFormatter() -> DateFormatter {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "HH:mm, d MMMM yyyy, EEEE"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.init(identifier: "ru_BY")
        
        return dateFormatter
    }
    
    static func createStringDate(withSecondsIntervalSince1970 seconds: TimeInterval) -> String {
        
        let date = Date.init(timeIntervalSince1970: seconds)
        
        return self.dateFormatter().string(from: date).lowercased()
    }
    
    static func createStringDateLatestActivity(fromDate date: Date) -> String {
        
        return self.dateFormatter().string(from:date).lowercased()
    }
}
