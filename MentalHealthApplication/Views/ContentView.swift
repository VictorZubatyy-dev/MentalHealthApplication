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
    let color = ColorPallete()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var body: some View {
        if !userCreated.isEmpty {
            TabView{
                JournalView()
                    .tabItem {
                        Label("Journal", systemImage: "list.bullet.clipboard")
                    }
                HealthView()
                    .tabItem {
                        Label("Health", systemImage: "heart.fill")
                    }
                SettingsView()
                    .tabItem {
                        Label{Text("Settings")} icon: {Image("customgear")
                            }
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
