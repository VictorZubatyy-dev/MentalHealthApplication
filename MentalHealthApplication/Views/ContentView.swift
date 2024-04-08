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
import UserNotifications

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage("userCreated") private var userCreated = ""
    @AppStorage("notificationPermission") private var userNotificationPermission = ""

    var body: some View {
        if !userCreated.isEmpty {
            TabView{
                JournalView()
                    .tabItem {
                        Label("Journal", systemImage: "list.bullet.clipboard")
                    }
                    .onAppear(perform: checkNotificationPremission)
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
    
    func checkNotificationPremission(){
        if userNotificationPermission.isEmpty{
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    userNotificationPermission = "true"
                    setNotificationForToday()
                } else if let error {
                    print(error.localizedDescription)
                }
            }
        }
        else if userNotificationPermission == "true"{
            setNotificationForToday()
        }
    }
    
    func setNotificationForToday(){
        let content = UNMutableNotificationContent()
        content.title = "mentjour."
        content.subtitle = "Log todays experiences..."
        content.sound = UNNotificationSound.default
        
        let currentDate = Date()
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
        dateComponents.hour = 20 // 8:00pm
        dateComponents.minute = 00
        
        guard let eightPMDate = Calendar.current.date(from: dateComponents) else {
            fatalError("Unable to create the date for 8:00 PM.")
        }
        
        let now = Date.now
        
        if now < eightPMDate{
            let timeInterval = eightPMDate.timeIntervalSinceNow
            if timeInterval > 0{
                // show this notification at 8:00pm
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // remove all notifications and add the newest
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}
