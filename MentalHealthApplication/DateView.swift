//
//  DateView.swift
//  MentalHealthApplication
//
//  Created by Victor on 13/12/2023.
//

import SwiftUI

struct DateView: View {
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()

    var body: some View {
        DatePicker(
                "Date of Birth",
                selection: $date,
                displayedComponents: [.date]
            )
//        .transformEffect(.init(scaleX: 0.7, y: 0.7))
        .datePickerStyle(.wheel)
        Button("Cancel") {
                    dismiss()
                }
                .font(.title)
                .padding()
    }
}

#Preview {
    DateView()
}
