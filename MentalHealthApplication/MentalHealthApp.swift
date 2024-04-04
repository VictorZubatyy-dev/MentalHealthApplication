//
//  MentalHealthApplicationApp.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import HealthKit
import SwiftData

@main
struct MentalHealthApplicati4onApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Log.self, Alcohol.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
