//
//  HealthView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import HealthKit
import SwiftData


struct HealthView: View {
    @EnvironmentObject var HK: HealthManager
    
    var body: some View {
        VStack{
            List(HK.HKSamples, id: \.self){ minute in
                VStack(alignment: .leading) {
                    Text("\(minute)")
                }
            }
        }
    }
}






