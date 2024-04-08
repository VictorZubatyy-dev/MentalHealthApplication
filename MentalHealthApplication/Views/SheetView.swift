//
//  SheetView.swift
//  MentalHealthApplication
//
//  Created by Victor on 06/03/2024.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    let darkGray = Color(white: 0.1500)
    let lightGray = Color(white: 0.2000)
    
    var body: some View {
            VStack{
                HStack{
                    Spacer().frame(width: 170)
                    Text("Sleep").bold()
                        .foregroundStyle(.white)
                    Spacer()
                    Button("Back") {
                        dismiss()
                    }
                    .foregroundStyle(.blue)
                }
                .padding(.top,  25)
                .padding(.trailing, 25)
                
                List{
                    Text("The sleep score is a prediction of your sleep quality/efficiency for the day.")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Using a machine learning model, multiple factors are used to calculate this prediction such as:")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("⏰ Sleep duration").bold()
                        .font(.title3)
                    Text("• The amount of time spent asleep.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                    
                    Text("🛌 Bedtime").bold()
                        .font(.title3)
                    Text("• The time you went to sleep at.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                    
                    Text("⚥   Gender").bold()
                        .font(.title3)
                    Text("• Health related queries differ for male and females.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("😪 REM sleep").bold()
                        .font(.title3)
                    Text("• The total amount of REM sleep to be spent during sleep.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("😴 Deep sleep").bold()
                        .font(.title3)
                    Text("• The total amount of deep sleep to be spent during sleep.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                        .fixedSize(horizontal: false, vertical: true)

                    
                    Text("🥱 Awakenings").bold()
                        .font(.title3)
                    Text("• The average amount of awakenings during sleep.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                        .fixedSize(horizontal: false, vertical: true)

                    
                    Text("☕️ Caffeine").bold()
                        .font(.title3)
                    Text("• The total amount of caffeine consumed during the day.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                        .fixedSize(horizontal: false, vertical: true)

                    
                    Text("🍺 Alcohol").bold()
                        .font(.title3)
                    Text("• The total amount of alcohol consumed during the day.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                    
                    Text("🚬 Smoking Status").bold()
                        .font(.title3)
                    Text("• Whether you are a smoker or not.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                    
                    Text("🏃 Exercise").bold()
                        .font(.title3)
                    Text("• The average amount of exercise during the week.")
                        .font(.subheadline)
                        .padding(.leading, 20)
                }
                .padding()
                .frame(alignment: .leading)
            }
    }
}

#Preview {
    SheetView()
}
