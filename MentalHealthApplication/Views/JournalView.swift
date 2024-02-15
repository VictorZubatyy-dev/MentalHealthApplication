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
    @AppStorage("userCreated") private var userCreated = ""

    var body: some View {
        VStack{
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
            }
        }
    }
    
    func addEntry(){
        let log = Log()
        modelContext.insert(log)
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
