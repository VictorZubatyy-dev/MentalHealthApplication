//
//  HealthManager.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import Foundation
import HealthKit
import SwiftData
import CoreML

class HealthManager: ObservableObject{
    @Published var HKSamples = [HKQuantity]()
    @Published var SleepEfficiencyValue = 0.0

    func getModel(){
        do {let model = try SleepEfficiency(configuration: MLModelConfiguration())
            let prediction = try model.prediction(Age: 20, Gender: 0, Sleep_duration: 8, REM_sleep_percentage: 20, Deep_sleep_percentage: 20, Awakenings: 2, Caffeine_consumption: 20, Alcohol_consumption: 1, Smoking_status: 0, Exercise_frequency: 3, Bedtime_Hour: 10, Bedtime_Minutes: 10)
            print("Prediction: \(prediction.Sleep_efficiency)")
            SleepEfficiencyValue = prediction.Sleep_efficiency
        }
        catch{fatalError("Model failed to load")}
    }
    
    func checkHealthKit(){

        if HKHealthStore.isHealthDataAvailable() {

            let healthStore = HKHealthStore()
            
            let type = Set([HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!])
            
            healthStore.requestAuthorization(toShare: nil, read: type) { (success, error) in
                if !success {
                    // Handle the error here.
                }
                else{
                    guard let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime) else {
                        fatalError("*** This method should never fail ***")
                    }
                    let today = Date()

                    let sort = [
                        // We want descending order to get the most recent date FIRST
                        NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
                    ]
                    
                    let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: sort) {
                        query, results, error in
                        
                        guard let samples = results as? [HKQuantitySample] else {
                            // Handle any errors here.
                            return
                        }
                                                
                        for sample in samples {
                            let date = sample.startDate
                            print(sample)
                            print(date)
                            DispatchQueue.main.async{
                                self.HKSamples = [sample.quantity]
                                healthStore.stop(query)
                            }
                            break
                        }
                        print(self.HKSamples)
                    }
                    healthStore.execute(query)
                }
            }
        }
    }
}

