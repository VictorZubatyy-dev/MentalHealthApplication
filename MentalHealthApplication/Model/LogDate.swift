//
//  LogDate.swift
//  MentalHealthApplication
//
//  Created by Victor on 12/03/2024.
//

import Foundation

class LogDate: ObservableObject {
    @Published var dateChosen = Date()
    @Published var dateActive = false
}
