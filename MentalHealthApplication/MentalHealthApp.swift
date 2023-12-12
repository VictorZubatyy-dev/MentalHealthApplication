//
//  MentalHealthApplicationApp.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import HealthKit
import CoreML

@main
struct MentalHealthApplicationApp: App {
//    initalise empty statobject
    @StateObject var HK = HealthManager()

    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(HK)
        }
//        just model Entry used for SwiftData storage
        .modelContainer(for: Entry.self)
    }
}
