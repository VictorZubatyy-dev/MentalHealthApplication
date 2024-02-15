//
//  ContentView.swift
//  MentalHealthApplication
//
//  Created by Victor on 14/02/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //  State objects for initialising the enivironment objects to be used on both tab/onboarding views
    @StateObject var HK = HealthManager()
    @StateObject var userDetails = Users()
    //  key used as bool for onboarding state
    @AppStorage(Constants.currentOnboardingVersion) var hasSeenOnboardingView = false
    var body: some View {
        if hasSeenOnboardingView {
            TabView{
                JournalView()
                    .tabItem {
                        Label("Journal", systemImage: "list.bullet.clipboard")
                    }
                    .onAppear()
                HealthView()
                    .tabItem {
                        Label("Health", systemImage: "heart")
                    }
                    .onAppear(perform: HK.checkHealthKit)
                //                        .onAppear(perform: HK.getModel)
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .environmentObject(HK)
            .environmentObject(userDetails)
        }
        else {
            OnboardingView()
                .environmentObject(userDetails)
                .onAppear(perform: addUser)
        }
    }
    
    func addUser(){
        let user = User()
        modelContext.insert(user)
        userDetails.user.append(user)
    }
}

//#Preview {
//    ContentView()
//}
///
