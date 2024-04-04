//
//  SuggestionView.swift
//  MentalHealthApplication
//
//  Created by Victor on 29/03/2024.
//

import SwiftUI
import JournalingSuggestions

struct SuggestionView: View {
    @Environment(\.dismiss) var dismiss

    @State private var suggestionTitle: String? = nil
    @Bindable var log: Log

    var body: some View {
        JournalingSuggestionsPicker{
            Text("Select Journaling Suggestion")
        }
    onCompletion: {
        suggestion in
        suggestionTitle = suggestion.title
        log.entry = suggestionTitle ?? ""
    }
        Text(suggestionTitle ?? "")
        Button("Press to dismiss") {
                   dismiss()
               }
               .font(.title)
               .padding()
               .background(.black)
    }
    
}

//#Preview {
//    SuggestionView()
//}
