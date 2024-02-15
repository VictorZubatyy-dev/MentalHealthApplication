//
//  EditUserView.swift
//  MentalHealthApplication
//
//  Created by Victor on 01/02/2024.
//

import SwiftUI
import SwiftData

struct EditUserView2: View {
    @Binding var user: User
    var body: some View {
        Form{
//            TextField("Name:", text:$user.name, axis: .vertical)
            TextField("Age:", text:$user.age, axis: .vertical)
//            TextField("Gender:", text:$user.gender, axis: .vertical)
//            TextField("Awakenings", text:$user.awakenings, axis: .vertical)
//            TextField("Feeling", text:$log.user.name)
        }
        .navigationTitle("Edit")
    }
}

