//
//  Int+DateFormatter.swift
//  weather
//
//  Created by Dinar on 05.01.2025.
//

import UIKit

extension Int {
    func timeStringFromTimeStamp() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let timeFormatter = DateFormatterService.shared
        let timeString = timeFormatter.timeFormatter.string(from: date)
        return timeString
    }
    
    func weekStringFromimeStamp() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let weekFormatter = DateFormatterService.shared
        let weekString = weekFormatter.weekFormatter.string(from: date)
        return weekString
    }
}
