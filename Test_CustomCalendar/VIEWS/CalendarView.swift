//
//  ContentView.swift
//  Test_CustomCalendar
//
//  Created by Jaroslaw Trojanowicz on 04/10/2022.
//

import SwiftUI

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView

    init(
        interval: DateInterval,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            // interate through the dates representing months (dates within particular months)
            ForEach(months, id: \.self) { month in
                Section(header: header(for: month)) {
                    ForEach(0..<7) { index in
                        Text(Calendar.current.shortWeekdaySymbols[index])
                    }
                    // interate through the days from "Monday" of the monthFirstWeek to "Sunday" of the monthLastWeek
                    ForEach(days(for: month), id: \.self) { date in
                        //check if those two dates are in the same month:
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date).id(date)
                        } else {
                            content(date).hidden()
                        }
                    }
                }
            }
        }
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0) // day 1 of a month (meaning: every start of a month)
        )
    }

    private func header(for month: Date) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month

        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }

    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end), // from Monday (or whatever day is a first day in the given calendar) of a monthFirstWeek to Sunday of a monthLastWeek
            matching: DateComponents(hour: 0, minute: 0, second: 0) // every start of a day
        )
    }
}

struct CalendarView_Previews: PreviewProvider {
    
    @Environment(\.calendar) static var calendar
    
    static var previews: some View {
        // Show only one month:
//        CalendarView(interval: .init(), showHeaders: true) { date in
//            Text(DateFormatter.day.string(from: date))
//                .padding(8)
//                .background(Color.blue)
//                .cornerRadius(8)
//        }
        
        // Shows whole year
        ScrollView {
            CalendarView(interval: calendar.dateInterval(of: .year, for: Date.now)!, showHeaders: true) { date in
                Text(DateFormatter.day.string(from: date))
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
    }
}
