//
//  Test_CustomCalendarApp.swift
//  Test_CustomCalendar
//
//  Created by Jaroslaw Trojanowicz on 04/10/2022.
//

import SwiftUI

// Original source code/article:
// https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec
// https://swiftwithmajid.com/2020/05/06/building-calendar-without-uicollectionview-in-swiftui/

@main
struct Test_CustomCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            CalendarView(interval: .init()) { _ in
                Text("30")
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
    }
}
