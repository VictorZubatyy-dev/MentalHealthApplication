//
//  HealthView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import HealthKit
import SwiftData
import CoreML

struct HealthView: View {
    @EnvironmentObject var HK: HealthManager
    
    var body: some View {
        VStack{
            Text("Health")
                .fontWeight(.bold)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top], 30)
                .padding([.leading], 10)
            List(HK.HKSamples, id: \.self){ minute in
                VStack(alignment: .leading) {
                    Text("\(minute)")
                }
            }
        }
    }
}








