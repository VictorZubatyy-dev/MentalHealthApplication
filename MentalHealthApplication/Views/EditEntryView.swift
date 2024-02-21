//
//  EditEntryView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditEntryView: View {
    @Bindable var log: Log
    @State private var selectedItem: PhotosPickerItem?
        
    var body: some View {
        VStack(alignment: .leading){
            Text("Today, \(log.date, formatter: dateFormatter)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(y: -40)
                .offset(x: 25)
            
            TextField("Start writing...", text:$log.entry, axis: .vertical)
                .lineLimit(5)
                .offset(y: -20)
                .offset(x: 25)
                .frame(width: 385)
            
            Text("Mood")
                .offset(x: 25)
                .fontWeight(.semibold)
            
            Picker("Mood", selection: $log.mood){
                ForEach(Mood.allCases){mood in
                    Text(mood.rawValue)
                }
            }
            .offset(y: -38)
            .offset(x: 75)
            
            Text("Alcohol")
                .offset(x: 25)
                .fontWeight(.semibold)
            Picker("Alcohol", selection: $log.alcohol.alcoholType){
                ForEach(AlcoholType.allCases){type in
                    Text(type.rawValue)
                }
            }
            .offset(y: -38)
            .offset(x: 75)
            
            
//            Text("Caffeine")
//                .fontWeight(.semibold)
//            Picker("Caffeine", selection: $log.caffeine.caffeineType){
//                ForEach(CaffeineType.allCases){type in
//                    Text(type.rawValue)
//                }
//            }

            
            switch log.alcohol.alcoholType{
            case .none:
                EmptyView()
            case .🍷:
                Text("Type")
                    .offset(x: 25)
                    .fontWeight(.semibold)
                Picker("Alcohol Type", selection: $log.alcohol.alcoholWineType){
                    ForEach(AlcoholWineType.allCases){wineType in
                        Text(wineType.rawValue)
                    }
                }
                .offset(y: -38)
                .offset(x: 75)
                
                Text("Amount")
                    .offset(x: 25)
                    .fontWeight(.semibold)
                Picker("Alcohol Amount", selection: $log.alcohol.alcoholWineTypeAmount){
                    ForEach(AlcoholWineTypeAmount.allCases){wineTypeAmount in
                        Text(wineTypeAmount.rawValue)
                    }
                }
                .offset(y: -38)
                .offset(x: 75)
            case .🥃:
                Text("Type")
                    .offset(x: 25)
                    .fontWeight(.semibold)
                Picker("Alcohol", selection: $log.alcohol.alcoholSpiritType){
                    ForEach(AlcoholSpiritType.allCases){spiritType in
                        Text(spiritType.rawValue)
                    }
                }
                .offset(y: -38)
                .offset(x: 75)
                
                Text("Amount")
                    .offset(x: 25)
                    .fontWeight(.semibold)
                Picker("Alcohol Amount", selection: $log.alcohol.alcoholSpiritTypeAmount){
                    ForEach(AlcoholSpiritTypeAmount.allCases){spiritTypeAmount in
                        Text(spiritTypeAmount.rawValue)
                    }
                }
                .offset(y: -38)
                .offset(x: 75)
            }
            
            Form{
                Section{
                    // check that there is data stored
                    if let imageData = log.photo,
                       // check if the data is an image
                       let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    }
                    PhotosPicker(selection: $selectedItem, matching: .images){
                        Label("Select a photo that depicts your day", systemImage: "photo.on.rectangle.angled")
                    }
                }
            }
        }
        .background(Color.ListBGColor)
        .onChange(of: selectedItem, loadPhoto)
        .onChange(of: log.alcohol.alcoholType, setAlcoholAmountDefaultValue)
        .onChange(of: log.alcohol.alcoholWineTypeAmount, setWineTypeAmountValue)
        .onChange(of: log.alcohol.alcoholSpiritTypeAmount, setSpiritTypeAmountValue)
    }
    func loadPhoto(){
        // task runs on main actor, changes the image from the main actor
        Task { @MainActor in
            log.photo = try await selectedItem?.loadTransferable(type: Data.self)
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
}










