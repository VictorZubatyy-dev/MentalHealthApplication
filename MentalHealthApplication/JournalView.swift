//
//  JournalView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) var modelContext
    @Query var log: [Log]
    @State private var path = [Log]()
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false

    var body: some View {
        NavigationStack(path: $path){
            List {
                ForEach(log) { log in
                    NavigationLink(value: log){
                        VStack(alignment: .leading) {
                            Text(log.entry)
                                .font(.headline)
                            Text(log.feeling)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteEntries)
            }
            .navigationDestination(for: Log.self, destination: EditEntryView.init)
            .toolbar{
                Button("Add entry", systemImage: "plus", action: addEntry)
            }
            Button("Remove key", systemImage: "minus", action: removekey)
        }
        }
    
    func removekey(){
        hasSeenOnboardingView = false
    }

    func addEntry(){
        let log = Log()
//   inserted into model context
        modelContext.insert(log)
//   object is added to empty path state
        path = [log]
    }
    
    func deleteEntries(_ indexSet: IndexSet){
        for index in indexSet{
            let log = log[index]
            modelContext.delete(log)
        }
    }
}

//#Preview {
//    JournalView()
//}
