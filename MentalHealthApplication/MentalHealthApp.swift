//
//  MentalHealthApplicationApp.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import HealthKit

@main
struct MentalHealthApplicationApp: App {
    @StateObject var HK = HealthManager()
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(HK)
        }
        .modelContainer(for: Entry.self)
    }
}
