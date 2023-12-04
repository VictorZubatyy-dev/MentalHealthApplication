//
//  EditEntryView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData

struct EditEntryView: View {
    @Bindable var entry: Entry
    var body: some View {
        Form{
            TextField("Text", text:$entry.text, axis: .vertical)
            TextField("Feeling", text:$entry.feeling)
            DatePicker("Date", selection: $entry.date)
        }
        .navigationTitle("Edit Entry")
    }
}
