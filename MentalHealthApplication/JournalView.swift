//
//  JournalView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    //  model container environment variable used to access model context of container attached to content view
    @Environment(\.modelContext) var modelContext
    //  sort entry objects
    @Query(sort: \Entry.date, order: .reverse) var entries: [Entry]
    //  Listening to changes made in editEntryView
    @State private var path = [Entry]()
    var body: some View {
        NavigationStack(path: $path){
            List {
                ForEach(entries) { entry in
                    NavigationLink(value: entry){
                        VStack(alignment: .leading) {
                            Text(entry.text)
                                .font(.headline)
                            Text(entry.feeling)
                                .font(.subheadline)
                            Text(entry.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteEntries)
            }
            .navigationTitle("Logs")
            .navigationDestination(for: Entry.self, destination: EditEntryView.init)
            .toolbar{
                Button("Add entry", systemImage: "plus", action: addEntry)
            }
        }
    }
    
    func addEntry(){
        //      empty entry object
        let entry = Entry()
        //      inserted into model context
        modelContext.insert(entry)
        //      object is added to empty path state
        path = [entry]
    }
    
    func deleteEntries(_ indexSet: IndexSet){
        for index in indexSet{
            let entry = entries[index]
            modelContext.delete(entry)
        }
    }
}


#Preview {
    JournalView()
}
