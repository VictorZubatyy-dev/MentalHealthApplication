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
            ZStack{
                darkGray
                    .ignoresSafeArea()
                Text("Sleep").bold()
                    .foregroundStyle(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 800, alignment: .top)
                Button("Done") {
                    dismiss()
                }
                .font(.title3)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                VStack(alignment: .leading, spacing: 10){
                    Text("The sleep efficiency value is a prediction of your sleep quality for the day.")
                    Text("Using a machine learning model, multiple factors are used to calculate this predication such as:")
                }
                .foregroundStyle(.white)
                .frame(minWidth: 0, maxWidth: 370, minHeight: 0, maxHeight: 600, alignment: .topLeading)
                .padding()
                .background(lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                VStack(alignment: .leading, spacing: 10){
                            Text("⏰ Sleep").bold()
                                .font(.title3)
                            Text("🛌 Bedtime").bold()
                                .font(.title3)
                            Text("🛌 Bedtime").bold()
                                .font(.title3)
                }
                .foregroundStyle(.white)
                .frame(minWidth: 0, maxWidth: 370, minHeight: 0, maxHeight: 370, alignment: .topLeading)
            }
    }
}

#Preview {
    SheetView()
}
