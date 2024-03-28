//
//  CalendarView.swift
//  MentalHealthApplication
//
//  Created by Victor on 12/03/2024.
//

import SwiftUI

struct CalendarView: View {
    @Binding var logDate: Date
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            Spacer()
            Button("Done") {
                dismiss()
            }
        }
        .font(.body)
        .padding()
        DatePicker(
            "Start Date",
            selection: $logDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        
        Spacer()
        Text("Chosen date, \(logDate, formatter: dateFormatter)")
    }
}

#Preview {
    CalendarView(logDate: Binding<Date>.constant(Date.now))
}
