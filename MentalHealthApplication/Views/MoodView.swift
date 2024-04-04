//
//  MoodView.swift
//  MentalHealthApplication
//
//  Created by Victor on 14/03/2024.
//

import SwiftUI

struct MoodView: View {
    @Binding var chosenMood: String
    @Environment(\.dismiss) var dismiss
    let mood = ["none", "🙁", "😕", "😐", "🙂", "😁"]
    
    var body: some View {
        HStack{
            Spacer()
            Button("Done") {
                dismiss()
            }
        }
        .font(.body)
        .padding()
        
        Picker("Mood", selection: $chosenMood){
            ForEach(mood, id: \.self){ mood in
                Text(mood)
            }
        }
        
        Spacer()
        Text("Chosen mood \(chosenMood)")
    }
}

#Preview {
    MoodView(chosenMood: Binding<String>.constant(""))
}
