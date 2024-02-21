//
//  LogView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/03/2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct LogView: View {
    @Environment(\.modelContext) var modelContext
    @Query var log: [Log]
    let color = ColorPallete()
    
    var body: some View {
        List {
            ForEach(log) { log in
                NavigationLink(value: log){
                    VStack(alignment: .leading, spacing: 5) {
                        
                        HStack{
                            Text(log.entry).bold()
                            switch log.mood{
                            case .none:
                                EmptyView()
                            case .😕:
                                Text(log.mood.rawValue)
                                    .font(.title2)
                            case .🙁:
                                Text(log.mood.rawValue)
                                    .font(.title2)
                            case.😐:
                                Text(log.mood.rawValue)
                                    .font(.title2)
                            case.🙂:
                                Text(log.mood.rawValue)
                                    .font(.title2)
                            case.😁:
                                Text(log.mood.rawValue)
                                    .font(.title2)
                            }
                        }
                        
                        switch log.alcohol.alcoholType{
                        case .none:
                            EmptyView()
                        case .🍷:
                            Text("Alcohol").bold()
                            HStack{
                                Text(log.alcohol.alcoholWineTypeAmount.rawValue + " of " + log.alcohol.alcoholWineType.rawValue)
                                    .font(.subheadline)
                                Text(log.alcohol.alcoholType.rawValue)
                                    .font(.subheadline)
                            }
                            Text("\(log.alcohol.alcoholBeverageTypeAmountValue)")
                            
                        case .🥃:
                            HStack{
                                Text(log.alcohol.alcoholSpiritTypeAmount.rawValue + " of " + log.alcohol.alcoholSpiritType.rawValue).bold()
                                Text(log.alcohol.alcoholType.rawValue)
                            }
                            Text("\(log.alcohol.alcoholBeverageTypeAmountValue)")
                        }
                        
                        Section{
                            //check that there is data stored
                            if let imageData = log.photo,
                               //check if the data is an image
                               let uiImage = UIImage(data: imageData){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .scaledToFit()
                            }
                            Text("\(log.date, formatter: dateFormatter)")
                                .font(.footnote)
                                .scaledToFit()
                        }
                    }
                }
                .listRowBackground(Color.cyan)
                .foregroundStyle(.white)
                .listRowSpacing(5)
            }
            .onDelete(perform: deleteEntries)
        }
    }
    
    func deleteEntries(_ indexSet: IndexSet){
        for index in indexSet{
            let log = log[index]
            modelContext.delete(log)
        }
    }
}

//#Preview {
//    LogView()
//}
