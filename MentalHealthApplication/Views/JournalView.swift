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
    @State private var datePicked = false
    
    ///Background colour
    let gradient = ColorPallete()
    @State private var logDate = Date()
    @State var chosenMood = "none"
    @State private var allEntries = true
    @State private var showingDateSheet = false
    @State private var showingMoodSheet = false
    @State private var selectedFilter = ""
    
    var body: some View {
        NavigationStack(path: $path){
            LogView(allEntries: allEntries, searchDate: logDate, chosenMood: chosenMood)
                .navigationDestination(for: Log.self, destination: EditEntryView.init)
                .scrollContentBackground(.hidden)
                .background(gradient.backgroundGradient)
                .navigationTitle("\(userName) Logs")
                .navigationBarTitleTextColor(.white)
                .toolbar{
                    ToolbarItemGroup{
                        Button(action: addEntry){
                            Image(systemName: "plus").foregroundStyle(.white)
                        }
                        Menu{
                            Button("All entries"){
                                allEntries = true
                                chosenMood = "none"
                            }
                            Button("Date"){
                                allEntries = false
                                chosenMood = "none"
                                showingDateSheet.toggle()
                            }
                            Button("Mood"){
                                allEntries = false
                                showingMoodSheet.toggle()
                            }
                        }
                        
                    label: {
                        Label("", systemImage: "line.3.horizontal.decrease.circle.fill")
                    }
                    .sheet(isPresented: $showingDateSheet){
                        CalendarView(logDate: $logDate)
                    }
                    .sheet(isPresented: $showingMoodSheet){
                        MoodView(chosenMood: $chosenMood)
                    }
                    }
                }
        }
    }
    
    func addEntry(){
        ///Initialise objects
        let caffeine = Caffeine(caffeineType: CaffeineType.none, caffeineTeaType: CaffeineTeaType.black, caffeineCoffeeType: CaffeineCoffeeType.Americano, caffeineTeaTypeAmount: CaffeineTeaTypeAmount.Cup, caffeineCoffeeTypeAmount: CaffeineCoffeeTypeAmount.Small, caffeineBeverageTypeAmountValue: 0.0)
        let alcohol = Alcohol(alcoholType: AlcoholType.none, alcoholSpiritType: AlcoholSpiritType.Whiskey, alcoholWineType: AlcoholWineType.Red, alcoholSpiritTypeAmount: AlcoholSpiritTypeAmount.Jigger, alcoholWineTypeAmount: AlcoholWineTypeAmount.Glass, alcoholBeverageTypeAmountValue: 0.0)
        let songs = Songs(songName: "", songAlbumName: "", songArtistName: "", songDateListened: Date())
        let log = Log(date: Date(), entry: "", title: "", feeling: "", mood: "none", song: [songs], alcohol: alcohol, caffeine: caffeine)
        modelContext.insert(log)
        path.append(log)
    }
}

