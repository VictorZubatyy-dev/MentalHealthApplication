//
//  User.swift
//  MentalHealthApplication
//
//  Created by Victor on 10/02/2024.
//

import SwiftUI
import SwiftData

class Users: ObservableObject {
    @Published var user = [User]()
}
