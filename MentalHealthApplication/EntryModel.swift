//
//  EntryModel.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import Foundation
import SwiftData
import HealthKit

@Model
class Entry {
    var text: String
    var feeling: String
    var date: Date
    
//  initialised with default values
    init(text: String = "", feeling: String = "", date: Date = .now) {
        self.text = text
        self.feeling = feeling
        self.date = date
    }
}
