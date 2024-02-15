//
//  Model.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//
import Foundation
import SwiftData
import HealthKit

@Model
class Log {
    var date: Date
    var entry: String
    var feeling: String
    var caffeine: Double
    var alcohol: Double
    var exercise: Double

    init(date: Date = .now, entry: String = "", feeling: String = "", caffeine: Double = 0, alcohol: Double = 0, exercise: Double = 0) {
        self.date = date
        self.entry = entry
        self.feeling = feeling
        self.caffeine = caffeine
        self.alcohol = alcohol
        self.exercise = exercise
    }
}
