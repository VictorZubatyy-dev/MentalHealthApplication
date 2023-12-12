//
//  ContentView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var HK: HealthManager

    var body: some View {
        TabView{
            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "list.bullet.clipboard")
                }
            HealthView()
                .tabItem {
                    Label("Health", systemImage: "heart")
                }
                .onAppear(perform: HK.checkHealthKit)
                .onAppear(perform: HK.getModel)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}



#Preview {
    ContentView()
}
