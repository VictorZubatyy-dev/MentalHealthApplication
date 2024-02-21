//
//  DateFormatter.swift
//  MentalHealthApplication
//
//  Created by Victor on 04/03/2024.
//

import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none // Excludes time from the display
    return formatter
}()
