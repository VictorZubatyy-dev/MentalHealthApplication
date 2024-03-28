//
//  ContentView.swift
//  MentalHealthApplication
//
//  Created by Victor on 14/02/2024.
//

import SwiftUI
import Foundation
import HealthKit
import HealthKitUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage("userCreated") private var userCreated = ""
    var body: some View {
        if !userCreated.isEmpty {
            TabView{
                JournalView()
                    .tabItem {
                        Label("Journal", systemImage: "list.bullet.clipboard")
                    }
                HealthView(totalCalories: [])
                    .tabItem {
                        Label("Health", systemImage: "heart.fill")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
        
        else {
            if(userCreated.isEmpty){
                OnboardingView()
            }
        }
    }
}

#Preview {
    ContentView()
}
///
