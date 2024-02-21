//
//  Model.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//
import Foundation
import SwiftData
import HealthKit

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

enum Mood: String, CaseIterable, Identifiable, Codable{
    case none, 🙁, 😕, 😐, 🙂, 😁
    var id: Self {self}
}

@Model
class Caffeine
{
    var caffeineType: CaffeineType
    var caffeineTeaType: CaffeineTeaType
    var caffeineBeverageTypeAmountValue: Double
    
    init(caffeineType: CaffeineType, caffeineTeaType: CaffeineTeaType, caffeineBeverageTypeAmountValue: Double) {
        self.caffeineType = caffeineType
        self.caffeineTeaType = caffeineTeaType
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
class Log {
    var date: Date
    var entry: String
    var feeling: String
    var exercise: Double
    var mood: Mood
    var alcohol: Alcohol
    var caffeine: Caffeine
    @Attribute(.externalStorage) var photo: Data?
    
    init(date: Date, entry: String, feeling: String, exercise: Double, mood: Mood, alcohol: Alcohol, caffeine: Caffeine) {
        self.date = date
        self.entry = entry
        self.feeling = feeling
        self.exercise = exercise
        self.mood = mood
        self.alcohol = alcohol
        self.caffeine = caffeine
    }
}
