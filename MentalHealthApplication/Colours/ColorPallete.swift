//
//  ColorPallete.swift
//  MentalHealthApplication
//
//  Created by Victor on 07/03/2024.
//

import Foundation

import SwiftUI
import SwiftData

struct ColorPallete{
    /// default background colour of log and health view
    var backgroundGradient = LinearGradient(
        colors: [.primaryCustomBlue, .secondaryCustomBlue],
        startPoint: .top, endPoint: .bottom)
    
    var defaultSleepGradient = LinearGradient(
        colors: [.blue, .mint],
        startPoint: .top, endPoint: .bottom)
    
    var logSuggestionGradient = LinearGradient(
        colors: [.indigo, .purple],
        startPoint: .top, endPoint: .bottom)
    
    /// health view mood background colours
    var defaultMoodGradient = LinearGradient(
        colors: [.indigo, .purple],
        startPoint: .top, endPoint: .bottom)
    
    var noMoodGradient = LinearGradient(
        colors: [.clear, .clear],
        startPoint: .top, endPoint: .bottom)

    var verySadMoodGradient = LinearGradient(
        colors: [.black, .gray],
        startPoint: .top, endPoint: .bottom)
    
    var sadMoodGradient = LinearGradient(
        colors: [.primaryCustomBlue, .blue],
        startPoint: .top, endPoint: .bottom)
    
    var contentMoodGradient = LinearGradient(
        colors: [.indigo, .purple],
        startPoint: .top, endPoint: .bottom)
    
    var happyMoodGradient = LinearGradient(
        colors: [.orange, .yellow],
        startPoint: .top, endPoint: .bottom)
    
    var veryHappyMoodGradient = LinearGradient(
        colors: [.green, .mint],
        startPoint: .top, endPoint: .bottom)
    
    var exerciseGoalNotAchieved = LinearGradient(
        colors: [.red, .orange],
        startPoint: .top, endPoint: .bottom)
    
    var exerciseGoalAchieved = LinearGradient(
        colors: [.green, .mint],
        startPoint: .top, endPoint: .bottom)
    
    var calorieGoalNotAchieved = LinearGradient(
        colors: [.red, .orange],
        startPoint: .top, endPoint: .bottom)
    
    var calorieGoalAchieved = LinearGradient(
        colors: [.green, .mint],
        startPoint: .top, endPoint: .bottom)
    
    ///log suggestion colour
    var logSuggestion  = Color.indigo
}
