//
//  Extension_DateFormatter.swift
//  Test_CustomCalendar
//
//  Created by Jaroslaw Trojanowicz on 04/10/2022.
//

import Foundation

extension DateFormatter {
    
    static var day: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

