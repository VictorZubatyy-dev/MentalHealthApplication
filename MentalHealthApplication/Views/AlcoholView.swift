//
//  AlcoholView.swift
//  MentalHealthApplication
//
//  Created by Victor on 29/02/2024.
//

import SwiftUI
import SwiftData

struct AlcoholView: View {
    @Binding var isAlcoholExpanded: Bool
   
//    @State var alcoholTypeList: [String]
//    @State private var alcoholTypeAmountList: [String] = []
//    @State private var alcoholicBeverageTypeAmount: String = ""
//    @State private var selectedDrink: String = ""
//    @State private var selectedAmount: Double = 0.0
//    @State private var alcoholChosenState = Alcohol.notchosen(reason: "User has not chosen an alcohol")
    let layout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        Text("Hi")
            .onTapGesture {
                
            }
//        if alcoholChosenState == .chosen{
//            Picker("Drink", selection: $selectedDrink){
//                ForEach(alcoholTypeList, id: \.self){ alcoholType in
//                    Text(alcoholType)
//                }
//            }
//        }
    }
//    func getAlcoholType(){
//        for alcohol in alcoholEmojis {
//            if alcohol.alcoholEmoji == log.alcoholType.alcoholEmoji{
//                for alcoholType in alcohol.alcoholType {
//                    alcoholTypeList.append(alcoholType)
//                }
//            }
//        }
//    }
    
//    func setAlcoholTypeList(){
//        log.alcoholType.alcoholType = selectedDrink
//        print("hi" + log.alcoholType.alcoholType)
//    }
    
//    func setAlcoholType(){
//        log.alcoholType.alcoholType = selectedDrink
//        print("hi" + log.alcoholType.alcoholType)
//    }
}
//
//#Preview {
//    AlcoholView()
//}
