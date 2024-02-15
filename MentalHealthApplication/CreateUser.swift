//
//  CreateUser.swift
//  MentalHealthApplication
//
//  Created by Victor on 13/02/2024.
//

import Foundation
import SwiftData
import SwiftUI

class CreateUser{
    @Environment(\.modelContext) var modelContext
    @ObservedObject var userDetails: Users
    
    init() {
        self.userDetails = Users()
        }
    
    func addUser(){
        let user = User()
        modelContext.insert(user)
        userDetails.user.append(user)
    }
}
