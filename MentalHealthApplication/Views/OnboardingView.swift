//
//  OnboardingView.swift
//  MentalHealthApplication
//
//  Created by Victor on 05/02/2024.
//

import SwiftUI

extension Color {
    public static let ListBGColor = Color(UIColor.secondarySystemBackground)
}

struct OnboardingView: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage("userCreated") private var userCreated = ""
    @AppStorage("userName") private var userName = ""
    
    @State private var selectedView = 1
    let maxNumberOfScreens = 2
    
    var body: some View {
        VStack (alignment: .center){
            TabView(selection: $selectedView) {
                OnboardingUserScreen().tag(1)
                OnboardingHealthScreen().tag(2)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Button(selectedView == maxNumberOfScreens ? "Done" : "Next") {
                if selectedView == maxNumberOfScreens {
                    userCreated = "user"
                } else {
                    selectedView += 1
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical)
        }.background(Color.ListBGColor)
            .ignoresSafeArea(.all)
    }
}
