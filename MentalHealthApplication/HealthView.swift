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
    @EnvironmentObject var userDetails: Users
    
    var body: some View {
        VStack{
            Text("Health")
                .fontWeight(.bold)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top], 30)
                .padding([.leading], 10)
            Text("Sleep Efficiency: \(HK.SleepEfficiencyValue)")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading], 10)
            List(HK.HKSamples, id: \.self){ minute in
                VStack(alignment: .leading) {
                    Text("\(minute)")
                }
            }
            
            Button(action: check){
                Text("hi")
                if (!userDetails.user.isEmpty){
                    Text("User:\(userDetails.user[0].age)")
                }
            }
//            Button("check", action: check){
//               
//            }
           

//            if (!userDetails.user.isEmpty){
//                Form{
//                    TextField("Age:", text:$userDetails.user[0].age, axis: .vertical)
//                        .disabled(true)
//                }
//                .navigationTitle("Edit Entry")
            }
        }
    func check(){
        print(userDetails.user.count)
    }
    }








