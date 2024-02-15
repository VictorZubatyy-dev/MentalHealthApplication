//
//  EditEntryView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData

struct EditEntryView: View {
    @Bindable var log: Log
    var body: some View {
        Form{
            TextField("Text", text:$log.entry, axis: .vertical)
            TextField("Feeling", text:$log.feeling)
        }
        .navigationTitle("Edit Entry")
    }
}
