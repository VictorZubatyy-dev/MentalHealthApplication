//
//  Model.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//
import Foundation
import SwiftData
import HealthKit

//@Model
//class Sleep
//{
//    var SleepEfficiency: [Double]
//    var rem_sleep: Double
//    var deep_sleep: Double
//    var caffeine: Double
//    var alcohol: Double
//    var bedtime_hour: Double
//    var bedtime_minutes: Double
//    var sleep_duration: Double
//    var rest_type: String
//    
//    init(SleepEfficiency: [Double] = [], rem_sleep: Double, deep_sleep: Double, caffeine: Double, alcohol: Double, bedtime_hour: Double, bedtime_minutes: Double, sleep_duration: Double, rest_type: String) {
//        self.SleepEfficiency = SleepEfficiency
//        self.rem_sleep = rem_sleep
//        self.deep_sleep = deep_sleep
//        self.caffeine = caffeine
//        self.alcohol = alcohol
//        self.bedtime_hour = bedtime_hour
//        self.bedtime_minutes = bedtime_minutes
//        self.sleep_duration = sleep_duration
//        self.rest_type = rest_type
//    }
//}

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

@Model
class User{
    var name: String
    var age: String
    var gender: String
    var awakenings: [Double]
    var smokingStatus: [Int]
    var Exercise_frequency: Double
    var Exercise_goal: Double
    var Sleep_goal: Double
    
    init(name: String = "", age: String = "", gender: String = "", awakenings: [Double] = [0], smokingStatus: [Int] = [0], Exercise_frequency: Double = 0, Exercise_goal: Double = 0, Sleep_goal: Double = 0) {
        self.name = name
        self.age = age
        self.gender = gender
        self.smokingStatus = smokingStatus
        self.awakenings = awakenings
        self.Exercise_frequency = Exercise_frequency
        self.Exercise_goal = Exercise_goal
        self.Sleep_goal = Sleep_goal
    }
}
