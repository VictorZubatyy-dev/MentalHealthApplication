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
                        
                        if let song = log.song.first?.songAlbumName{
                            if !song.isEmpty{
                                if log.song.count >= 1 && log.song.count < 3{
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
                        }
                        
                        
                        else{
                            EmptyView()
                        }
                        
                        Spacer().frame(height:10)
                        HStack(alignment: .firstTextBaseline){
                            Text(log.entry)
                            Text(log.mood != "none" ? log.mood : "").font(.title2)
                                .frame(height: 5)
                        }
                        
                        .frame(alignment: .leading)
                        .padding()
                        .background(ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(log.mood != "none" ? gradient.logSuggestionGradient : LinearGradient(
                                    colors: [.clear, .clear],
                                    startPoint: .top, endPoint: .bottom), lineWidth: 3)
                        })
                        switch log.alcohol.alcoholType{
                        case .none:
                            EmptyView()
                        case .🍷:
                            Spacer().frame(height: 10)
                            Text("Alcohol").bold()
                            HStack{
                                Text(log.alcohol.alcoholWineTypeAmount.rawValue + " of " + log.alcohol.alcoholWineType.rawValue)
                                Text(log.alcohol.alcoholType.rawValue)
                            }
                            .font(.subheadline)
                            Text(String(format: "%.2f oz of alcohol", log.alcohol.alcoholBeverageTypeAmountValue))
                                .font(.subheadline)
                        case .🥃:
                            Spacer().frame(height: 10)
                            Text("Alcohol").bold()
                            HStack{
                                Text(log.alcohol.alcoholSpiritTypeAmount.rawValue + " of " + log.alcohol.alcoholSpiritType.rawValue)
                                Text(log.alcohol.alcoholType.rawValue)
                            }
                            .font(.subheadline)
                            Text(String(format: "%.2f oz of alcohol", log.alcohol.alcoholBeverageTypeAmountValue))
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
    
    
    init(allEntries: Bool,
         searchDate: Date,
         chosenMood: String) {
        
        let predicate = Log.predicate(allEntries: allEntries, searchDate: searchDate, chosenMood: chosenMood)
        
        _logs = Query(filter: predicate)
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
    
    func deleteEntries(_ indexSet: IndexSet){
        for index in indexSet{
            let log = logs[index]
            modelContext.delete(log)
        }
    }
}
