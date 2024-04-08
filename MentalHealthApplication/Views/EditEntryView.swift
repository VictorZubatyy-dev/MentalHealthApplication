//
//  EditEntryView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData
import JournalingSuggestions
import HealthKit

struct EditEntryView: View {
    @Bindable var log: Log
    @FocusState private var entryIsFocused: Bool
    @FocusState private var titleEntryIsFocused: Bool
    
    @State private var suggestionTitle: String? = nil
    @State private var suggestionSong = [JournalingSuggestion.Song]()
    
    @State private var showingAlert: Bool = false
    @State private var logEntryText: String = "Start writing ..."
    
    let gradient = ColorPallete()
    
    let mood = ["none", "🙁", "😕", "😐", "🙂", "😁"]
    
    var body: some View {
        if log.alcohol.alcoholType.rawValue != "none" || log.caffeine.caffeineType.rawValue != "none"{
            ScrollView(showsIndicators: false){
                ZStack(alignment: .topLeading){
                    VStack(alignment: .leading){
                        Text("Today, \(log.date, formatter: dateFormatterFullMonthName)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .alert("You must not exceed more than 2 songs.", isPresented: $showingAlert) {
                                Button("Ok", role: .cancel) { }
                            }
                        HStack{
                            Spacer()
                            titleEntryIsFocused ?
                            Button("Done") {
                                titleEntryIsFocused = false
                            }.frame(height: 5) : Button(""){
                                
                            }.frame(height: 5)
                        }
                        .frame(alignment: .trailing)
                        
                        if let album = log.song.first?.songAlbumName{
                            if album.isEmpty{
                                EmptyView()
                            }
                            else{
                                TextField(log.title, text:$log.title, axis: .vertical)
                                    .bold().font(.title3)
                                    .lineLimit(2, reservesSpace: true)
                                    .focused($titleEntryIsFocused)
                            }
                        }
                        
                        if let album = log.song.first?.songAlbumName{
                            if !album.isEmpty{
                                VStack(alignment: .leading){
                                        ForEach(log.song, id: \.songID){song in
                                            Text(song.songAlbumName + song.songArtistName)
                                                .foregroundStyle(.white)
                                                .font(.headline).bold()
                                            Text(song.songName)
                                                .foregroundStyle(.white)
                                                .font(.subheadline)
                                        }
                                }
                                .padding()
                                .foregroundStyle(.white)
                                .frame(maxHeight: .infinity, alignment: .leading)
                                .background(ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(gradient.logSuggestionGradient)
                                })
                            }
                        }
                        
                        else {
                            EmptyView()
                        }
                        
                        HStack{
                            Spacer()
                            entryIsFocused ?
                            Button("Done") {
                                entryIsFocused = false
                            }.frame(height: 5) : Button(""){
                                
                            }.frame(height: 5)
                        }
                        .frame(alignment: .trailing)
                        
                        
                        
                        TextField(logEntryText, text:$log.entry, axis: .vertical)
                            .focused($entryIsFocused)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(4, reservesSpace: true)
                        
                        HStack{
                            Spacer()
                            JournalingSuggestionsPicker{
                                Label("Suggestion", systemImage: "wand.and.stars")
                                    .padding(5)
                                    .font(.subheadline)
                                    .labelStyle(.titleAndIcon)
                                    .font(.subheadline).bold()
                                    .foregroundStyle(.white)
                                    .background(ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(gradient.logSuggestionGradient)
                                    })
                            }
                        onCompletion: {
                            suggestion in
                            suggestionTitle = suggestion.title
                            if let suggestionSongTitle = suggestionTitle{
                                log.title = suggestionSongTitle
                            }
                            suggestionSong = await suggestion.content(forType: JournalingSuggestion.Song.self)
                            print(suggestionSong.count)
                            if suggestionSong.count > 2{
                                showingAlert.toggle()
                                print(showingAlert)
                            }
                            
                            else{
                                if let album = suggestionSong.first?.album{
                                    if album.isEmpty{
                                        logEntryText = "Start writing ..."
                                    }
                                    else{
                                        logEntryText = "What were you doing/feeling whilst listening to this music?"
                                        log.title = log.title + " 🎵"
                                        addSong()
                                    }
                                }
                            }
                        }
                            Spacer()
                        }
                        
                        Text("How are you feeling?")
                            .foregroundStyle(.gray)
                        HStack{
                            Text("Mood")
                                .fontWeight(.semibold)
                            
                            Picker("Mood", selection: $log.mood){
                                ForEach(mood, id: \.self){ mood in
                                    Text(mood)
                                }
                            }
                        }
                        Text("What did you drink today?")
                            .foregroundStyle(.gray)
                        HStack{
                            Text("Alcohol")
                                .fontWeight(.semibold)
                            Picker("Alcohol", selection: $log.alcohol.alcoholType){
                                ForEach(AlcoholType.allCases){type in
                                    Text(type.rawValue)
                                }
                            }
                            Spacer()
                            Text("Caffeine")
                                .fontWeight(.semibold)
                            Picker("Caffeine", selection: $log.caffeine.caffeineType){
                                ForEach(CaffeineType.allCases){type in
                                    Text(type.rawValue)
                                }
                            }
                            
                        }
                        HStack{
                            //alcohol type
                            switch log.alcohol.alcoholType{
                            case .none:
                                EmptyView()
                            case .🍷:
                                Text("Type")
                                    .fontWeight(.semibold)
                                Picker("Alcohol Type", selection: $log.alcohol.alcoholWineType){
                                    ForEach(AlcoholWineType.allCases){wineType in
                                        Text(wineType.rawValue)
                                    }
                                }
                            case.🥃:
                                Text("Type")
                                    .fontWeight(.semibold)
                                Picker("Alcohol Type", selection: $log.alcohol.alcoholSpiritType){
                                    ForEach(AlcoholSpiritType.allCases){spiritType in
                                        Text(spiritType.rawValue)
                                    }
                                }
                            }
                            
                            //caffeine type
                            switch log.caffeine.caffeineType{
                            case .none:
                                EmptyView()
                            case .tea:
                                Spacer()
                                Text("Type")
                                    .fontWeight(.semibold)
                                Picker("Tea Type", selection: $log.caffeine.caffeineTeaType){
                                    ForEach(CaffeineTeaType.allCases){teaType in
                                        Text(teaType.rawValue)
                                    }
                                }
                                
                            case .coffee:
                                Spacer()
                                Text("Type")
                                    .fontWeight(.semibold)
                                Picker("Coffee Type", selection: $log.caffeine.caffeineCoffeeType){
                                    ForEach(CaffeineCoffeeType.allCases){coffeeType in
                                        Text(coffeeType.rawValue)
                                    }
                                }
                            }
                        }
                        
                        HStack{
                            switch log.alcohol.alcoholType{
                            case.none:
                                EmptyView()
                            case .🍷:
                                Text("Amount")
                                    .fontWeight(.semibold)
                                Picker("Wine Amount", selection: $log.alcohol.alcoholWineTypeAmount){
                                    ForEach(AlcoholWineTypeAmount.allCases){wineTypeAmount in
                                        Text(wineTypeAmount.rawValue)
                                    }
                                }
                            case .🥃:
                                Text("Amount")
                                    .fontWeight(.semibold)
                                Picker("Spirit Amount", selection: $log.alcohol.alcoholSpiritTypeAmount){
                                    ForEach(AlcoholSpiritTypeAmount.allCases){spiritTypeAmount in
                                        Text(spiritTypeAmount.rawValue)
                                    }
                                }
                            }
                            
                            switch log.caffeine.caffeineType {
                            case .none:
                                EmptyView()
                            case .tea:
                                Spacer()
                                Text("Amount")
                                    .fontWeight(.semibold)
                                Picker("Tea Amount", selection: $log.caffeine.caffeineTeaTypeAmount){
                                    ForEach(CaffeineTeaTypeAmount.allCases){teaTypeAmount in
                                        Text(teaTypeAmount.rawValue)
                                    }
                                }
                            case .coffee:
                                Spacer()
                                Text("Amount")
                                    .fontWeight(.semibold)
                                Picker("Coffee Amount", selection: $log.caffeine.caffeineCoffeeTypeAmount){
                                    ForEach(CaffeineCoffeeTypeAmount.allCases){coffeeTypeAmount in
                                        Text(coffeeTypeAmount.rawValue)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .onChange(of: log.alcohol.alcoholType, setAlcoholAmountDefaultValue)
                    .onChange(of: log.alcohol.alcoholWineTypeAmount, setWineTypeAmountValue)
                    .onChange(of: log.alcohol.alcoholSpiritTypeAmount, setSpiritTypeAmountValue)
                    .onChange(of: log.caffeine.caffeineType, setCaffeineAmountDefaultValue)
                    .onChange(of: log.caffeine.caffeineTeaTypeAmount, setTeaTypeAmountValue)
                    .onChange(of: log.caffeine.caffeineCoffeeTypeAmount, setCoffeeTypeAmountValue)
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .ignoresSafeArea(.keyboard)
                Spacer()
            }
        }
        else{
            ZStack(alignment: .topLeading){
                VStack(alignment: .leading){
                    Text("Today, \(log.date, formatter: dateFormatterFullMonthName)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .alert("You must not exceed more than 2 songs.", isPresented: $showingAlert) {
                            Button("Ok", role: .cancel) { }
                        }
                    HStack{
                        Spacer()
                        titleEntryIsFocused ?
                        Button("Done") {
                            titleEntryIsFocused = false
                        }.frame(height: 5) : Button(""){
                            
                        }.frame(height: 5)
                    }
                    .frame(alignment: .trailing)
                    
                    if let album = log.song.first?.songAlbumName{
                        if album.isEmpty{
                            EmptyView()
                        }
                        else{
                            TextField(log.title, text:$log.title, axis: .vertical)
                                .bold().font(.title3)
                                .lineLimit(2, reservesSpace: true)
                                .focused($titleEntryIsFocused)
                        }
                    }
                    
                    if let album = log.song.first?.songAlbumName{
                        if !album.isEmpty{
                            VStack(alignment: .leading){
                                ForEach(log.song, id: \.songID){song in
                                    Text(song.songAlbumName + song.songArtistName)
                                        .foregroundStyle(.white)
                                        .font(.headline).bold()
                                        .fixedSize(horizontal: false, vertical: true)
                                    Text(song.songName)
                                        .foregroundStyle(.white)
                                        .font(.subheadline)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                            .padding()
                            .frame(maxHeight: .infinity, alignment: .leading)
                            .background(ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(gradient.logSuggestionGradient)
                            })
                        }
                    }
                    
                    HStack{
                        Spacer()
                        entryIsFocused ?
                        Button("Done") {
                            entryIsFocused = false
                        }.frame(height: 5) : Button(""){
                            
                        }.frame(height: 5)
                    }
                    .frame(alignment: .trailing)
                    
                    TextField(logEntryText, text:$log.entry, axis: .vertical)
                        .focused($entryIsFocused)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(4, reservesSpace: true)
                    
                    HStack{
                        Spacer()
                        JournalingSuggestionsPicker{
                            Label("Suggestion", systemImage: "wand.and.stars")
                                .padding(5)
                                .font(.subheadline)
                                .labelStyle(.titleAndIcon)
                                .font(.subheadline).bold()
                                .foregroundStyle(.white)
                                .background(ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(gradient.logSuggestionGradient)
                                })
                        }
                    onCompletion: {
                        suggestion in
                        suggestionTitle = suggestion.title
                        if let suggestionSongTitle = suggestionTitle{
                            log.title = suggestionSongTitle
                        }
                        suggestionSong = await suggestion.content(forType: JournalingSuggestion.Song.self)
                        print(suggestionSong.count)
                        if suggestionSong.count > 2{
                            showingAlert.toggle()
                            print(showingAlert)
                        }
                        
                        else{
                            if let album = suggestionSong.first?.album{
                                if album.isEmpty{
                                    logEntryText = "Start writing ..."
                                }
                                else{
                                    logEntryText = "What were you doing/feeling whilst listening to this music?"
                                    log.title = log.title + " 🎵"
                                    addSong()
                                }
                            }
                        }
                    }
                        Spacer()
                    }
                    Text("How are you feeling?")
                        .foregroundStyle(.gray)
                    HStack{
                        Text("Mood")
                            .fontWeight(.semibold)
                        
                        Picker("Mood", selection: $log.mood){
                            ForEach(mood, id: \.self){ mood in
                                Text(mood)
                            }
                        }
                    }
                    Text("What did you drink today?")
                        .foregroundStyle(.gray)
                    HStack{
                        Text("Alcohol")
                            .fontWeight(.semibold)
                        Picker("Alcohol", selection: $log.alcohol.alcoholType){
                            ForEach(AlcoholType.allCases){type in
                                Text(type.rawValue)
                            }
                        }
                        Spacer()
                        Text("Caffeine")
                            .fontWeight(.semibold)
                        Picker("Caffeine", selection: $log.caffeine.caffeineType){
                            ForEach(CaffeineType.allCases){type in
                                Text(type.rawValue)
                            }
                        }
                        
                    }
                    HStack{
                        //alcohol type
                        switch log.alcohol.alcoholType{
                        case .none:
                            EmptyView()
                        case .🍷:
                            Text("Type")
                                .fontWeight(.semibold)
                            Picker("Alcohol Type", selection: $log.alcohol.alcoholWineType){
                                ForEach(AlcoholWineType.allCases){wineType in
                                    Text(wineType.rawValue)
                                }
                            }
                        case.🥃:
                            Text("Type")
                                .fontWeight(.semibold)
                            Picker("Alcohol Type", selection: $log.alcohol.alcoholSpiritType){
                                ForEach(AlcoholSpiritType.allCases){spiritType in
                                    Text(spiritType.rawValue)
                                }
                            }
                        }
                        
                        //caffeine type
                        switch log.caffeine.caffeineType{
                        case .none:
                            EmptyView()
                        case .tea:
                            Spacer()
                            Text("Type")
                                .fontWeight(.semibold)
                            Picker("Tea Type", selection: $log.caffeine.caffeineTeaType){
                                ForEach(CaffeineTeaType.allCases){teaType in
                                    Text(teaType.rawValue)
                                }
                            }
                            
                        case .coffee:
                            Spacer()
                            Text("Type")
                                .fontWeight(.semibold)
                            Picker("Coffee Type", selection: $log.caffeine.caffeineCoffeeType){
                                ForEach(CaffeineCoffeeType.allCases){coffeeType in
                                    Text(coffeeType.rawValue)
                                }
                            }
                        }
                    }
                    
                    HStack{
                        switch log.alcohol.alcoholType{
                        case.none:
                            EmptyView()
                        case .🍷:
                            Text("Amount")
                                .fontWeight(.semibold)
                            Picker("Wine Amount", selection: $log.alcohol.alcoholWineTypeAmount){
                                ForEach(AlcoholWineTypeAmount.allCases){wineTypeAmount in
                                    Text(wineTypeAmount.rawValue)
                                }
                            }
                        case .🥃:
                            Text("Amount")
                                .fontWeight(.semibold)
                            Picker("Spirit Amount", selection: $log.alcohol.alcoholSpiritTypeAmount){
                                ForEach(AlcoholSpiritTypeAmount.allCases){spiritTypeAmount in
                                    Text(spiritTypeAmount.rawValue)
                                }
                            }
                        }
                        
                        switch log.caffeine.caffeineType {
                        case .none:
                            EmptyView()
                        case .tea:
                            Spacer()
                            Text("Amount")
                                .fontWeight(.semibold)
                            Picker("Tea Amount", selection: $log.caffeine.caffeineTeaTypeAmount){
                                ForEach(CaffeineTeaTypeAmount.allCases){teaTypeAmount in
                                    Text(teaTypeAmount.rawValue)
                                }
                            }
                        case .coffee:
                            Spacer()
                            Text("Amount")
                                .fontWeight(.semibold)
                            Picker("Coffee Amount", selection: $log.caffeine.caffeineCoffeeTypeAmount){
                                ForEach(CaffeineCoffeeTypeAmount.allCases){coffeeTypeAmount in
                                    Text(coffeeTypeAmount.rawValue)
                                }
                            }
                        }
                    }
                    
                }
                .padding()
                .onChange(of: log.alcohol.alcoholType, setAlcoholAmountDefaultValue)
                .onChange(of: log.alcohol.alcoholWineTypeAmount, setWineTypeAmountValue)
                .onChange(of: log.alcohol.alcoholSpiritTypeAmount, setSpiritTypeAmountValue)
                .onChange(of: log.caffeine.caffeineType, setCaffeineAmountDefaultValue)
                .onChange(of: log.caffeine.caffeineTeaTypeAmount, setTeaTypeAmountValue)
                .onChange(of: log.caffeine.caffeineCoffeeTypeAmount, setCoffeeTypeAmountValue)
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            Spacer()
        }
    }
    
    func addSong(){
        log.song.removeAll()
        for song in suggestionSong{
            log.song.append(Songs(songName: song.song! + " 🎶", songAlbumName: song.album! + " 💿", songArtistName: " by " + (song.artist ?? ""), songDateListened: song.date ?? Date()))
        }
    }
    
    func setAlcoholAmountDefaultValue(){
        switch log.alcohol.alcoholType{
        case .none:
            log.alcohol.alcoholBeverageTypeAmountValue = 0.0
        case .🍷:
            log.alcohol.alcoholBeverageTypeAmountValue = 5.0
        case .🥃:
            log.alcohol.alcoholBeverageTypeAmountValue = 2.0
        }
    }
    
    func setWineTypeAmountValue(){
        switch log.alcohol.alcoholWineTypeAmount {
        case .Glass:
            log.alcohol.alcoholBeverageTypeAmountValue = 5.0
        case .HalfAGlass:
            log.alcohol.alcoholBeverageTypeAmountValue = 2.0
        }
    }
    
    func setSpiritTypeAmountValue(){
        switch log.alcohol.alcoholSpiritTypeAmount {
        case .Glass:
            log.alcohol.alcoholBeverageTypeAmountValue = 2.0
        case .Shot:
            log.alcohol.alcoholBeverageTypeAmountValue = 2.0
        case .Jigger:
            log.alcohol.alcoholBeverageTypeAmountValue = 3.0
        }
    }
    
    func setCoffeeTypeAmountValue(){
        switch log.caffeine.caffeineCoffeeTypeAmount {
        case .Small:
            log.caffeine.caffeineBeverageTypeAmountValue = 50.0
        case .Medium:
            log.caffeine.caffeineBeverageTypeAmountValue = 75.0
        case .Large:
            log.caffeine.caffeineBeverageTypeAmountValue = 200.0
        }
    }
    
    func setTeaTypeAmountValue(){
        switch log.caffeine.caffeineTeaTypeAmount {
        case .Cup:
            log.caffeine.caffeineBeverageTypeAmountValue = 50.0
        case .Mug:
            log.caffeine.caffeineBeverageTypeAmountValue = 75.0
        }
    }
    
    func setCaffeineAmountDefaultValue(){
        switch log.caffeine.caffeineType{
        case .none:
            log.caffeine.caffeineBeverageTypeAmountValue = 0.0
        case .tea:
            log.caffeine.caffeineBeverageTypeAmountValue = 25.0
        case .coffee:
            log.caffeine.caffeineBeverageTypeAmountValue = 50.0
        }
    }
}
