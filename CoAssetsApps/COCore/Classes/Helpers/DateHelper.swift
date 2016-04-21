//
//  DateHelper.swift
//  CoAssets-Agent
//
//  Created by Macintosh HD on 12/22/15.
//  Copyright © 2015 Nikmesoft Ltd. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func commonGMTDateFormater() -> NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.calendar = NSCalendar.currentCalendar()
        formatter.locale = NSLocale(localeIdentifier: NSLocale.preferredLanguages().last!)
        formatter.dateFormat = AppDefine.DateFormat.Common
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return formatter
    }
    
    static func notificationGMTDateFormater(dateString: String?) -> String {
        if let _ = dateString {
            let formatterServer = NSDateFormatter()
            formatterServer.dateFormat = AppDefine.DateFormat.Notification
            let date = formatterServer.dateFromString(dateString!)
            let newFormater = NSDateFormatter()
            newFormater.dateFormat = "dd/MM/yyyy HH:mm a"
            let dateString = newFormater.stringFromDate(date!)
            return dateString
        }
        return ""
    }
    
    class func photoDateAndTimeFormatter() -> NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.calendar = NSCalendar.currentCalendar()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        return formatter
    }
    
}
