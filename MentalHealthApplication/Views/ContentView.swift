//
//  ContentView.swift
//  MentalHealthApplication
//
//  Created by Victor on 14/02/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var HK = HealthManager()
    @AppStorage("userCreated") private var userCreated = ""
    
    var body: some View {
        if !userCreated.isEmpty {
            TabView{
                JournalView()
                    .tabItem {
                        Label("Journal", systemImage: "list.bullet.clipboard")
                    }
                HealthView()
                    .tabItem {
                        Label("Health", systemImage: "heart")
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

//#Preview {
//    ContentView()
//}
///
