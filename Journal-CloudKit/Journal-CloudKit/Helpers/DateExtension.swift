//
//  DateExtension.swift
//  Journal-CloudKit
//
//  Created by theevo on 3/30/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import Foundation

extension Date {
    /**
    Formats a date into a string using dateStyle.short and timeStyle.short
     */
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
