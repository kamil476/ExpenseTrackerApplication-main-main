//
//  DateExtension.swift
//  ExpenseTrackerApplication
//
//  Created by Kamil Kakar on 27/03/2025.
//

import Foundation

extension Date {
    func formattedTime() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a" // 12-hour format with AM/PM
            return dateFormatter.string(from: self)
        }
}
