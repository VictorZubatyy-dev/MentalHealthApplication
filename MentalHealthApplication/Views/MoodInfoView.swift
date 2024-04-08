//
//  MoodInfoView.swift
//  MentalHealthApplication
//
//  Created by Victor on 07/04/2024.
//

import SwiftUI

struct MoodInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    //colours used for the view
    let darkGray = Color(white: 0.1500)
    let lightGray = Color(white: 0.2000)
    
    //colours used to represent the different moods
    let gradient = ColorPallete()
    
    var body: some View {
        HStack{
            Spacer().frame(width: 170)
            Text("Mood").bold()
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
            Text("Your overall mood depicts how you were feeling throughout the day.")
                .fixedSize(horizontal: false, vertical: true)
            Text("Different colours are used to represent different mood. The following colours represent:")
                .fixedSize(horizontal: false, vertical: true)
            
            Text("Very sad").bold()
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(gradient.verySadMoodGradient)
                })
            
            Text("Sad").bold()
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(gradient.sadMoodGradient)
                })
            
            Text("Content").bold()
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(gradient.contentMoodGradient)
                })
            
            Text("Happy").bold()
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(gradient.happyMoodGradient)
                })
            
            Text("Very Happy").bold()
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(gradient.veryHappyMoodGradient)
                })
        }
        .padding()
        .frame(alignment: .leading)
    }
}


#Preview {
    MoodInfoView()
}
