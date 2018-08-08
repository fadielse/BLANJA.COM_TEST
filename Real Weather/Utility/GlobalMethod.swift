//
//  GlobalMethod.swift
//  Real Weather
//
//  Created by FADIELSE on 08.08.18.
//  Copyright © 2018 Fadielse. All rights reserved.
//

import Foundation

public func convertEpochToDate(withTimeStamp timeStamp: Int, AndFormat format: String) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: NSTimeZone.local.abbreviation()!)
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    let strDate = dateFormatter.string(from: date)
    
    return strDate
}

func convertToCelsius(fahrenheit: Int) -> Int {
    return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
}
