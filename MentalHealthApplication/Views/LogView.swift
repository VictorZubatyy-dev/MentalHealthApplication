//
//  LogView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/03/2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct LogView: View {
    @Environment(\.modelContext) var modelContext
    @Query var logs: [Log]
    var body: some View {
        List {
            ForEach(logs) { log in
                NavigationLink(value: log){
                    VStack(alignment: .leading, spacing: 5) {
                        HStack{
                            Text(log.entry).bold()
                            Text(log.mood != "none" ? log.mood : " ")
                        }
                        
                        switch log.alcohol.alcoholType{
                        case .none:
                            EmptyView()
                        case .🍷:
                            Text("Alcohol").bold()
                            HStack{
                                Text(log.alcohol.alcoholWineTypeAmount.rawValue + " of " + log.alcohol.alcoholWineType.rawValue)
                                Text(log.alcohol.alcoholType.rawValue)
                            }
                            .font(.subheadline)

                            Text("\(log.alcohol.alcoholBeverageTypeAmountValue) oz of alcohol")
                                .font(.subheadline)
                            
                        case .🥃:
                            Divider()
                            Text("Alcohol").bold()
                            HStack{
                                Text(log.alcohol.alcoholSpiritTypeAmount.rawValue + " of " + log.alcohol.alcoholSpiritType.rawValue)
                                Text(log.alcohol.alcoholType.rawValue)
                            }
                            .font(.subheadline)
                            
                            Text(String(format: "%.2f oz of alchol", log.alcohol.alcoholBeverageTypeAmountValue))
                                .font(.subheadline)
                        }
                        
                        switch log.caffeine.caffeineType {
                        case .none:
                            EmptyView()
                        case .tea:
                            Divider()
                            Text("Caffeine").bold()
                            HStack{
                                Text(log.caffeine.caffeineTeaTypeAmount.rawValue + " of " + log.caffeine.caffeineTeaType.rawValue)
                                Text(log.caffeine.caffeineType.rawValue)
                            }
                            .font(.subheadline)

                            Text(String(format: "%.2f mg of caffeine", log.caffeine.caffeineBeverageTypeAmountValue))
                                .font(.subheadline)

                        case .coffee:
                            Divider()
                            Text("Caffeine").bold()
                            HStack{
                                Text(log.caffeine.caffeineCoffeeTypeAmount.rawValue + " of " + log.caffeine.caffeineCoffeeType.rawValue)
                                Text(log.caffeine.caffeineType.rawValue)
                            }
                            .font(.subheadline)

                            Text("\(log.caffeine.caffeineBeverageTypeAmountValue) mg of caffeine")
                                .font(.subheadline)
                        }
                    }
                }
                .listRowSpacing(5)
                .listRowBackground(Color.primaryCustomBlue)
                .foregroundStyle(.white)
            }
            .onDelete(perform: deleteEntries)
        }
    }
    
    init(allEntries: Bool,
         searchDate: Date,
         chosenMood: String) {
        
        let predicate = Log.predicate(allEntries: allEntries, searchDate: searchDate, chosenMood: chosenMood)
        
        _logs = Query(filter: predicate)
    }
    
    func deleteEntries(_ indexSet: IndexSet){
        for index in indexSet{
            let log = logs[index]
            modelContext.delete(log)
        }
    }
}

//#Preview {
//    LogView(sort: SortDescriptor(\Log.entry), searchString: "")
//}
