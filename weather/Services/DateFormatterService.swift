//
//  DateFormatterService.swift
//  weather
//
//  Created by Dinar on 03.01.2025.
//

import UIKit

class DateFormatterService {
    static let shared = DateFormatterService()
    private let timeFormatter: DateFormatter
    private let weekFormatter: DateFormatter

    init() {
        timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "E, d MMM"
        weekFormatter.locale = Locale(identifier: "ru_RU")
    }
    
    func timeStringFromTimeStamp(timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let timeString = timeFormatter.string(from: date)
        return timeString
    }
    
    func weekStringFromimeStamp(timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        return weekFormatter.string(from: date)
    }
}

