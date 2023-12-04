//
//  HealthKit.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import Foundation
import SwiftData
import HealthKit

@Model
class HK {
    var exercise: HKQuantitySample
    
//  initialised with default values
    init(exercise: HKQuantitySample) {
        self.exercise = exercise
    }
}
