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
    @State private var totalAlcoholValue = 0.0
    @State private var sleepEfficiency = 0.0

    @Environment(\.modelContext) var modelContext
    
    @AppStorage("userName") private var userName = ""
    @AppStorage("userAge") private var userAge = 0
    @AppStorage("userGender") private var userGender = ""
    @AppStorage("userSmokingStatus") private var userSmokingStatus = ""
    @AppStorage("userAwakenings") private var userAwakenings = 0
    @AppStorage("exerciseFrequency") private var exerciseFrequency = 0
    @AppStorage("userExerciseGoal") private var userExerciseGoal = 0
    @AppStorage("userSleepGoalHour") private var userSleepGoalHour = 0
    @AppStorage("userSleepGoalMinute") private var userSleepGoalMinute = 0
    @AppStorage("userSleepBedTimeHour") private var userSleepBedTimeHour = 0
    @AppStorage("userSleepBedTimeMinute") private var userSleepBedTimeMinute = 0
    
    let stripeHeight = 15.0
    
    let color = ColorPallete()
    
    @State private var showingSheet = false
    
    var body: some View {
        ZStack{
            color.backgroundGradient
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                Text("Health").font(.largeTitle).bold()
                    .foregroundStyle(.white)
                    .offset(y: 26)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading){
                    Text("Sleep").font(.title2).bold()
                        .foregroundStyle(.white)
                    Text("Efficiency: \(sleepEfficiency)").bold()
                        .foregroundStyle(.white)
                    Text("Hours: ").bold()
                        .foregroundStyle(.white)
                    Text("Alcohol:\(totalAlcoholValue)").bold()
                        .foregroundStyle(.white)
                }
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.white)
                }
                .sheet(isPresented: $showingSheet) {
                            SheetView()
                        }
            }
            .padding()
            .padding(.top, stripeHeight)
            .background {
                        ZStack(alignment: .top) {
                            Rectangle()
                                .opacity(0.5)
                        }
                        .foregroundColor(.teal)
            }
            .clipShape(RoundedRectangle(cornerRadius: stripeHeight, style: .continuous))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .offset(y: 80)
        }
        .onAppear(perform: fetchLogs)
        .onAppear(perform: getModel)
    }

    func fetchLogs(){
        let fetchDescriptor = FetchDescriptor<Log>()
        var totalAlcoholFetchValue = 0.0
        totalAlcoholValue = 0.0
        do {
            try modelContext.delete(model: Log.self, where: #Predicate { log in
                log.entry.isEmpty})
        }
        catch{
            print("Failed to delete empty logs.")
        }
                
        do {
            try modelContext.enumerate(fetchDescriptor) {log in
                totalAlcoholFetchValue += log.alcohol.alcoholBeverageTypeAmountValue
                print(totalAlcoholFetchValue)
                totalAlcoholValue = totalAlcoholFetchValue
            }
        } catch {
            print("Failed to calculate log results.")
        }
        print("Total alcohol: \(totalAlcoholValue)")
    }
    
        func getModel(){
            //      converting string values to their corresponsing double values trained in the ML model
            var genderToML = 0
            var sleepHourToML = 0.0
            var sleepMinuteToML = 0.0
            var sleepGoalToML = 0.0
            var rem_Sleep = 0.0
            var deep_Sleep = 0.0
            var sleep_Awakenings = 0.0
            var smoking_Status = 0.0
    
            //      male = 0, female = 1 in model
    
            if userGender == "Male"{
                genderToML = 0
            }
    
            else{
                genderToML = 1
            }
    
            sleepHourToML = Double(userSleepGoalHour)
            print(sleepHourToML)
            sleepMinuteToML = Double(userSleepGoalMinute)
            print(sleepMinuteToML)
            //        ensure double variables are correctly formatted for model prediction
            if sleepMinuteToML == 30.0{
                sleepMinuteToML = 0.5
            }
    
            //        sleep goal formatted to double for ML model
            sleepGoalToML = sleepHourToML + sleepMinuteToML
            print(sleepGoalToML)
            
            //        rem sleep calculation
            rem_Sleep = ((sleepGoalToML * 60) / 25)
            print(rem_Sleep)
    
            //        deep sleep calculation
            deep_Sleep = ((sleepGoalToML * 60) / 25)
            print(deep_Sleep)
    
            sleep_Awakenings = Double(userAwakenings)
    
            //        caffeine
            //        alcohol
    
            //        smoking status
            if userSmokingStatus == "Yes"{
                smoking_Status = 0
            }
    
            else{
                smoking_Status = 1
            }
    
            do {
                let model = try SleepEfficiency(configuration: MLModelConfiguration())
                let prediction = try model.prediction(Age: Double(userAge), Gender: Double(genderToML), Sleep_duration: sleepGoalToML, REM_sleep_percentage: rem_Sleep, Deep_sleep_percentage: deep_Sleep, Awakenings: sleep_Awakenings, Caffeine_consumption:100, Alcohol_consumption: totalAlcoholValue, Smoking_status: smoking_Status, Exercise_frequency: Double(exerciseFrequency), Bedtime_Hour: Double(userSleepBedTimeHour), Bedtime_Minutes: Double(userSleepBedTimeMinute))
                print("Prediction: \(prediction.Sleep_efficiency)")
                sleepEfficiency = prediction.Sleep_efficiency
            }
            catch{fatalError("Model failed to load")}
        }
}


#Preview {
    HealthView()
}








