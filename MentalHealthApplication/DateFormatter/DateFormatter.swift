//
//  DateFormatter.swift
//  MentalHealthApplication
//
//  Created by Victor on 04/03/2024.
//

import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter
}()

let dateFormatterWithDay: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d"
    return formatter
}()
