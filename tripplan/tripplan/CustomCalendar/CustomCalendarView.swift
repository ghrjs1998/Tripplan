//
//  CustomCalendarView.swift
//  tripplan
//
//  Created by 박호건 on 10/29/24.
//

import SwiftUI

struct CustomCalendarView: View {
    @Binding var checkInDate: Date?
    @Binding var checkOutDate: Date?
    
    let onDatesSelected: (Date?, Date?) -> Void // 날짜 선택 콜백
    let today = Date()
    
    var body: some View {
        DatePicker(
            "날짜 선택",
            selection: Binding(
                get: { checkInDate ?? today },
                set: { newDate in
                    selectDate(newDate)
                }
            ),
            in: today...,
            displayedComponents: .date
        )
        .datePickerStyle(GraphicalDatePickerStyle())
        .padding()
    }

    private func selectDate(_ newDate: Date) {
        if checkInDate == nil || (checkOutDate != nil) {
            checkInDate = newDate
            checkOutDate = nil
        } else if let checkIn = checkInDate, newDate > checkIn {
            checkOutDate = newDate
        }
        onDatesSelected(checkInDate, checkOutDate)
    }
    
}

