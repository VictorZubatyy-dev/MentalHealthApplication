////
////  hahah.swift
////  MentalHealthApplication
////
////  Created by Victor on 14/03/2024.
////
//
//import Foundation
//
//switch log.alcohol.alcoholType{
//case .none:
//    EmptyView()
//case .🍷:
//    Text("Type")
//        .offset(x: 25)
//        .fontWeight(.semibold)
//    Picker("Alcohol Type", selection: $log.alcohol.alcoholWineType){
//        ForEach(AlcoholWineType.allCases){wineType in
//            Text(wineType.rawValue)
//        }
//    }
//    .offset(y: -38)
//    .offset(x: 75)
//    
//    Text("Amount")
//        .offset(x: 25)
//        .fontWeight(.semibold)
//    Picker("Alcohol Amount", selection: $log.alcohol.alcoholWineTypeAmount){
//        ForEach(AlcoholWineTypeAmount.allCases){wineTypeAmount in
//            Text(wineTypeAmount.rawValue)
//        }
//    }
//    .offset(y: -38)
//    .offset(x: 75)
//case .🥃:
//    Text("Type")
//        .offset(x: 25)
//        .fontWeight(.semibold)
//    Picker("Alcohol", selection: $log.alcohol.alcoholSpiritType){
//        ForEach(AlcoholSpiritType.allCases){spiritType in
//            Text(spiritType.rawValue)
//        }
//    }
//    .offset(y: -38)
//    .offset(x: 75)
//    
//    Text("Amount")
//        .offset(x: 25)
//        .fontWeight(.semibold)
//    Picker("Alcohol Amount", selection: $log.alcohol.alcoholSpiritTypeAmount){
//        ForEach(AlcoholSpiritTypeAmount.allCases){spiritTypeAmount in
//            Text(spiritTypeAmount.rawValue)
//        }
//    }
//    .offset(y: -38)
//    .offset(x: 75)
//}
//
//
//Text("Type")
//    .fontWeight(.semibold)
//
//Picker("Type", selection: $log.mood){
//    ForEach(Mood.allCases){mood in
//        Text(mood.rawValue)
//    }
//}
//.frame(height: 21)
//Text("Type")
//    .fontWeight(.semibold)
//    .padding(.leading, 18)
//
//Picker("Alcohol", selection: $log.mood){
//    ForEach(Mood.allCases){mood in
//        Text(mood.rawValue)
//    }
//}
//.frame(width:90, height: 21)
