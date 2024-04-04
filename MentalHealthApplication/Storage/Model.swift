//
//  Model.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//
import Foundation
import SwiftData
import HealthKit
import SwiftUI
import JournalingSuggestions

enum CaffeineCoffeeTypeAmount: String, Identifiable, CaseIterable, Codable{
    case Small, Medium, Large
    var id: Self {self}
}

enum CaffeineTeaTypeAmount: String, Identifiable, CaseIterable, Codable{
    case Cup, Mug
    var id: Self {self}
}

enum CaffeineCoffeeType: String, Identifiable, CaseIterable, Codable{
    case Espresso, Americano, Cappucino, Latte, Mocha, Flatwhite = "Flat White"
    var id: Self {self}
}

enum CaffeineTeaType: String, Identifiable, CaseIterable, Codable{
    case black = "Black tea", green = "Green tea"
    var id: Self {self}
}

enum CaffeineType: String, Identifiable, CaseIterable, Codable{
    case none, tea = "🫖", coffee = "☕️"
    var id: Self {self}
}

enum AlcoholSpiritTypeAmount: String, Identifiable, CaseIterable, Codable{
    case Glass, Shot, Jigger
    var id: Self {self}
}

enum AlcoholWineTypeAmount: String, Identifiable, CaseIterable, Codable{
    case Glass, HalfAGlass = "Half a Glass"
    var id: Self {self}
}

enum AlcoholWineType: String, Identifiable, CaseIterable, Codable{
    case Red = "Red Wine", White = "White Wine"
    var id: Self {self}
}

enum AlcoholSpiritType: String, Identifiable, CaseIterable, Codable{
    case Whiskey, Cognac, Vodka
    var id: Self {self}
}

enum AlcoholType: String, CaseIterable, Identifiable, Codable{
    case none, 🥃, 🍷
    var id: Self {self}
}

enum Mood: String, CaseIterable{
    case none, 🙁, 😕, 😐, 🙂, 😁
}


@Model
class Caffeine
{
    var caffeineType: CaffeineType
    var caffeineTeaType: CaffeineTeaType
    var caffeineCoffeeType: CaffeineCoffeeType
    var caffeineTeaTypeAmount: CaffeineTeaTypeAmount
    var caffeineCoffeeTypeAmount: CaffeineCoffeeTypeAmount
    var caffeineBeverageTypeAmountValue: Double
    
    init(caffeineType: CaffeineType, caffeineTeaType: CaffeineTeaType, caffeineCoffeeType: CaffeineCoffeeType, caffeineTeaTypeAmount: CaffeineTeaTypeAmount, caffeineCoffeeTypeAmount: CaffeineCoffeeTypeAmount, caffeineBeverageTypeAmountValue: Double) {
        self.caffeineType = caffeineType
        self.caffeineTeaType = caffeineTeaType
        self.caffeineCoffeeType = caffeineCoffeeType
        self.caffeineTeaTypeAmount = caffeineTeaTypeAmount
        self.caffeineCoffeeTypeAmount = caffeineCoffeeTypeAmount
        self.caffeineBeverageTypeAmountValue = caffeineBeverageTypeAmountValue
    }
}

@Model
class Alcohol{
    var alcoholType: AlcoholType
    var alcoholSpiritType: AlcoholSpiritType
    var alcoholWineType: AlcoholWineType
    var alcoholSpiritTypeAmount: AlcoholSpiritTypeAmount
    var alcoholWineTypeAmount: AlcoholWineTypeAmount
    var alcoholBeverageTypeAmountValue: Double
    
    init(alcoholType: AlcoholType, alcoholSpiritType: AlcoholSpiritType, alcoholWineType: AlcoholWineType, alcoholSpiritTypeAmount: AlcoholSpiritTypeAmount, alcoholWineTypeAmount: AlcoholWineTypeAmount, alcoholBeverageTypeAmountValue: Double) {
        self.alcoholType = alcoholType
        self.alcoholSpiritType = alcoholSpiritType
        self.alcoholWineType = alcoholWineType
        self.alcoholSpiritTypeAmount = alcoholSpiritTypeAmount
        self.alcoholWineTypeAmount = alcoholWineTypeAmount
        self.alcoholBeverageTypeAmountValue = alcoholBeverageTypeAmountValue
    }
}

@Model
class Songs{
    let songID = UUID()
    var songName: String
    var songAlbumName: String
    var songArtistName: String
    var songDateListened: Date
    
    init(songName: String, songAlbumName: String, songArtistName: String, songDateListened: Date) {
        self.songName = songName
        self.songAlbumName = songAlbumName
        self.songArtistName = songArtistName
        self.songDateListened = songDateListened
    }
}

@Model
class Log{
    var date: Date
    var entry: String
    var title: String
    var feeling: String
    var mood: String
    var song: [Songs]
    var alcohol: Alcohol
    var caffeine: Caffeine
    @Attribute(.externalStorage) var photo: Data?
    
    init(date: Date, entry: String, title: String, feeling: String, mood: String, song: [Songs], alcohol: Alcohol, caffeine: Caffeine) {
        self.date = date
        self.entry = entry
        self.title = title
        self.feeling = feeling
        self.mood = mood
        self.song = song
        self.alcohol = alcohol
        self.caffeine = caffeine
    }
}

extension Log {
    /// A filter that checks for logs with the chosen date.
    static func predicate(
        allEntries: Bool,
        searchDate: Date,
        chosenMood: String
    ) -> Predicate<Log> {
        
        if (allEntries){
            return #Predicate<Log> { log in
                (!log.entry.isEmpty)
            }
        }
    
        else if (chosenMood != "none"){
            return #Predicate<Log> { log in
                log.mood == chosenMood
            }
        }
        
        else if (!allEntries && chosenMood == "none"){
            let calendar = Calendar.autoupdatingCurrent
            let start = calendar.startOfDay(for: searchDate)
            let end = calendar.date(byAdding: .init(day: 1), to: start) ?? start
            
            return #Predicate<Log> { log in
                (log.date > start && log.date < end)
                &&
                (!log.entry.isEmpty)
            }
        }
        
        else{
            return #Predicate<Log> { log in
                (!log.entry.isEmpty)
            }
        }
    }
}
