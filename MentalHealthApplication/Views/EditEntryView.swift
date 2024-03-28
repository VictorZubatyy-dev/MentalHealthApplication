//
//  EditEntryView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData
import PhotosUI
import JournalingSuggestions

struct EditEntryView: View {
    @Bindable var log: Log
    @State private var selectedItem: PhotosPickerItem?
    @State private var suggestionTitle: String? = nil

    let mood = ["none", "🙁", "😕", "😐", "🙂", "😁"]
    
    var body: some View {
        ZStack(alignment: .topLeading){
            
            JournalingSuggestionsPicker{
                Text("Select Journaling Suggestion")
            }
            onCompletion: {
                suggestion in
                suggestionTitle = suggestion.title
            }
            
            Text(suggestionTitle ?? "")
            
            VStack(alignment: .leading){
                Text("Today, \(log.date, formatter: dateFormatter)")
                    .frame(maxHeight: .infinity)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                TextField("Start writing...", text:$log.entry, axis: .vertical)
                    .frame(maxHeight: .infinity)
                    .lineLimit(5)
            }
            .padding()
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxHeight: 200, alignment: .topLeading)
            
            VStack(alignment: .leading){
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
            }
            .padding()
            .frame(height: 450)
            
            VStack(alignment: .leading){
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
                .frame(maxWidth: .infinity)
                
                HStack{
                    //                    alcohol type
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
                    
                    
                    //                    caffeine type
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
                .frame(width: 350)
                
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
                .frame(width:350)
                
            }
            .padding()
            .frame(height: 700, alignment: .leading)
            .onChange(of: selectedItem, loadPhoto)
            .onChange(of: log.alcohol.alcoholType, setAlcoholAmountDefaultValue)
            .onChange(of: log.alcohol.alcoholWineTypeAmount, setWineTypeAmountValue)
            .onChange(of: log.alcohol.alcoholSpiritTypeAmount, setSpiritTypeAmountValue)
            .onChange(of: log.caffeine.caffeineType, setCaffeineAmountDefaultValue)
            .onChange(of: log.caffeine.caffeineTeaTypeAmount, setTeaTypeAmountValue)
            .onChange(of: log.caffeine.caffeineCoffeeTypeAmount, setCoffeeTypeAmountValue)
            
        }
    }
    func loadPhoto(){
        // task runs on main actor, changes the image from the main actor
        Task { @MainActor in
            log.photo = try await selectedItem?.loadTransferable(type: Data.self)
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
