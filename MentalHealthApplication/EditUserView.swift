//
//  EditUserView.swift
//  MentalHealthApplication
//
//  Created by Victor on 01/02/2024.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Bindable var user: User
    var body: some View {
        Form{
            TextField("Name:", text:$user.name)
            TextField("Age:", text:$user.age)
            TextField("Gender:", text:$user.gender)
//            TextField("Awakenings", text:$user.awakenings, axis: .vertical)
//            TextField("Feeling", text:$log.user.name)
        }
        .navigationTitle("Edit")
    }
}

