//
//  JournalView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData
import PhotosUI

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}

struct JournalView: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage("userCreated") private var userCreated = ""
    @AppStorage("userName") private var userName = ""
    @State private var selectedEmoji = ""
    @State private var path = [Log]()
    let color = ColorPallete()
    
    
    var body: some View {
        NavigationStack(path: $path){
            LogView()
                .navigationDestination(for: Log.self, destination: EditEntryView.init)
                .scrollContentBackground(.hidden)
                .background(color.backgroundGradient)
                .navigationTitle("\(userName) Logs")
                .navigationBarTitleTextColor(.white)
                .toolbar{
                    Button(action: addEntry){
                        Image(systemName: "plus").foregroundStyle(.white)
                    }
                }
        }
    }
    
    func addEntry(){
        var logDate: Date {
            let calendar = Calendar.current
            let now = Date()
            let components = calendar.dateComponents([.year, .month, .day], from: now)
            let logDate = calendar.date(from: components)!
            return logDate
        }
        //        Initialise objects
        let caffeine = Caffeine(caffeineType: CaffeineType.none, caffeineTeaType: CaffeineTeaType.black, caffeineBeverageTypeAmountValue: 0.0)
        let alcohol = Alcohol(alcoholType: AlcoholType.none, alcoholSpiritType: AlcoholSpiritType.Whiskey, alcoholWineType: AlcoholWineType.Red, alcoholSpiritTypeAmount: AlcoholSpiritTypeAmount.Jigger, alcoholWineTypeAmount: AlcoholWineTypeAmount.Glass, alcoholBeverageTypeAmountValue: 0.0)
        let log = Log(date: logDate, entry: "", feeling: "", exercise: 0.0, mood: Mood.none, alcohol: alcohol, caffeine: caffeine)
        modelContext.insert(log)
        path.append(log)
    }
}

//#Preview {
//    JournalView()
//}

