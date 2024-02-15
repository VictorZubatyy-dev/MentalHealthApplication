//
//  SettingsView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    @EnvironmentObject var userDetails: Users
    
    var body: some View {
        NavigationStack(path: $userDetails.user){
            List {
                ForEach(users) { (users) in
                    NavigationLink(value: users){
                        VStack(alignment: .leading) {
                            Text("Name:\(users.name)")
                                .font(.headline)
                            Text("Age:\(users.age)")
                                .font(.headline)
                            Text("Gender:\(users.gender)")
                                .font(.headline)
//                            Text("Smoking Status:\(users.smokingStatus)")
//                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteEntries)
            }
            .navigationTitle("Settings")
            .navigationDestination(for: User.self, destination: EditUserView.init)
        }
    }
    
    func deleteEntries(_ indexSet: IndexSet){
        for index in indexSet{
            let user = users[index]
            modelContext.delete(user)
        }
    }
}


//#Preview {
//    SettingsView()
//}
