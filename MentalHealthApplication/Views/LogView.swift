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
    
    let gradient = ColorPallete()
    @State private var moodColour = LinearGradient.init(colors: [Color.purple], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 0.0))
    
    var body: some View {
        List{
            ForEach(logs) { log in
                NavigationLink(value: log){
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(alignment: .firstTextBaseline){
                            Text(log.title).bold().font(.title2)
                        }
                        
                        if let album = log.song.first?.songAlbumName{
                            if !album.isEmpty{
                                    VStack(alignment: .leading){
                                        ForEach(log.song, id: \.songID){song in
                                            Text(song.songAlbumName + song.songArtistName)
                                                .font(.headline).bold()
                                            Text(song.songName)
                                                .font(.subheadline)
                                            Divider()
                                        }
                                        if let song = log.song.first?.songDateListened{
                                            Text("Date listened: \(song, formatter: dateFormatterWithDay)")
                                                .font(.footnote)
                                        }
                                    }
                                    .padding()
                                    .frame(width: 280, alignment: .leading)
                                    .background(ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(gradient.logSuggestionGradient)
                                    })
                                }
                            }
                        
                        else{
                            EmptyView()
                        }
                        
                        Spacer().frame(height:10)
                        if !log.entry.isEmpty || log.mood != "none"{
                            HStack(alignment: .firstTextBaseline){
                                Text(log.entry)
                                Text(log.mood != "none" ? log.mood : "").font(.title2)
                                    .frame(height: 5)
                            }
                            .frame(alignment: .leading)
                            .padding()
                            .background(ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(gradient.logSuggestionGradient)
                            })
                        }
                        else {
                            EmptyView()
                        }
                        
                        switch log.alcohol.alcoholType{
                        case .none:
                            EmptyView()
                        case .🍷:
                            Spacer().frame(height: 10)
                            Text("Alcohol").bold()
                            HStack{
                                Text(log.alcohol.alcoholWineTypeAmount.rawValue + " of " + log.alcohol.alcoholWineType.rawValue)
                                Text(log.alcohol.alcoholType.rawValue)
                                Text(String(format: "(%.1f oz)", log.alcohol.alcoholBeverageTypeAmountValue))
                                    .font(.subheadline)
                            }
                            .font(.subheadline)
                        case .🥃:
                            Spacer().frame(height: 10)
                            Text("Alcohol").bold()
                            HStack{
                                Text(log.alcohol.alcoholSpiritTypeAmount.rawValue + " of " + log.alcohol.alcoholSpiritType.rawValue)
                                Text(log.alcohol.alcoholType.rawValue)
                                Text(String(format: "(%.1f oz)", log.alcohol.alcoholBeverageTypeAmountValue))
                                    .font(.subheadline)
                            }
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
                                Text("(\(Int(log.caffeine.caffeineBeverageTypeAmountValue)) mg)")
                                    .font(.subheadline)
                            }
                            .font(.subheadline)
                            
                        case .coffee:
                            Divider()
                            Text("Caffeine").bold()
                            HStack{
                                Text(log.caffeine.caffeineCoffeeTypeAmount.rawValue + " " + log.caffeine.caffeineCoffeeType.rawValue)
                                Text(log.caffeine.caffeineType.rawValue)
                                Text("(\(Int(log.caffeine.caffeineBeverageTypeAmountValue)) mg)")
                                    .font(.subheadline)
                            }
                            .font(.subheadline)
                            
                            
                        }
                        Divider()
                        Text("\(log.date, formatter: dateFormatter)")
                            .font(.footnote)
                    }
                }
                .listRowSpacing(10)
                .listRowBackground(Color.primaryCustomBlue)
                .foregroundStyle(.white)
            }
            .onDelete(perform: deleteEntries)
        }
        .listRowSpacing(20)
        .overlay{
            if logs.isEmpty{
                VStack{
                    ContentUnavailableView("No logs", systemImage: "pencil.line", description: Text("Start journaling by creating logs."))
                        .frame(alignment: .top)
                        .background(Color.clear)
                }
            }
        }
    }
    
    
//    filter initialisation
    init(allEntries: Bool,
         searchDate: Date,
         chosenMood: String) {

        let predicate = Log.predicate(allEntries: allEntries, searchDate: searchDate, chosenMood: chosenMood)
        
        _logs = Query(filter: predicate, sort: [SortDescriptor(\Log.date, order: .reverse)])
    }
    
    func getMoodStatus(mood: Mood) -> LinearGradient?{
        switch mood{
        case .none:
            return gradient.noMoodGradient
        case .🙁:
            return gradient.verySadMoodGradient
        case .😕:
            return gradient.sadMoodGradient
        case .😐:
            return gradient.contentMoodGradient
        case .🙂:
            return gradient.happyMoodGradient
        case .😁:
            return gradient.veryHappyMoodGradient
        }
    }
    
//    delete logs function
    func deleteEntries(_ indexSet: IndexSet){
        for index in indexSet{
            let log = logs[index]
            modelContext.delete(log)
        }
    }
}
