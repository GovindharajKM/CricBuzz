//
//  Extensions.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 10/01/21.
//

import Foundation
import UIKit


extension Date {
    
    func convertStringToDate(_ str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: str)!
    }
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}

extension CALayer {
    func roundedCorner() {
        self.cornerRadius = self.frame.width / 2
    }
    
    func setBorder() {
        self.borderWidth = 0.5
        self.borderColor = UIColor.lightGray.cgColor
    }
}

extension UITableViewCell {
    /// Generated cell identifier derived from class name
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
}


extension NSNotification.Name {
    static let notificationThemeChange = Notification.Name("notificationThemeChange")
}
