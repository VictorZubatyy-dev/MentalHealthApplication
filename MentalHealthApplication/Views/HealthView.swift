//
//  HealthView.swift
//  MentalHealthApplication
//
//  Created by Victor on 03/12/2023.
//

import SwiftUI
import HealthKit
import HealthKitUI
import SwiftData
import CoreML
import Charts

struct HealthView: View {
    @Environment(\.modelContext) var modelContext
    /// track the total alcohol, caffeine user has consumed for the day
    @State private var totalAlcoholValue = 0.0
    @State private var totalCaffeineValue = 0.0
    /// sleep efficiency prediction value
    @State private var sleepEfficiency = 0.0
        
    /// colours for the health, sleep, mood view
    let gradient = ColorPallete()
    @State private var moodColour = LinearGradient.init(colors: [Color.purple], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 0.0))
    
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
    
    @State private var showingSheet = false
    
    @State private var moods: NSSet.Element = ""
    @State private var moodss = ""
    @State private var sharing: HKAuthorizationStatus = HKAuthorizationStatus.notDetermined
    @State private var sharingExerciseTime: HKAuthorizationStatus = HKAuthorizationStatus.notDetermined
    
    @Query var logs: [Log]

    @State private var set = NSMutableSet()
    
    /// Calories struct for storing HK queries
    struct Calories: Identifiable {
        var day: String
        var calories: Double
        var colour: String
        var id = UUID()
    }
    
    /// Exercise struct for storing HK queries
    struct Exercise: Identifiable {
        var day: String
        var exercise: Double
        var colour: String
        var id = UUID()
    }
    
/// Past 7 days calories and exercise struct state
    @State private var calories: [Calories] = []
    @State private var exercise: [Exercise] = []
    @State private var exerciseDate: [String] = []
    @State private var calorieDate: [String] = []

    
///    Todays exercise goals
    @State private var todaysExercise: Double = 0.0
    @State private var todaysExerciseGoal: Double = 0.0
    @State private var exerciseGoal: HKQuantity = HKQuantity.init(unit: HKUnit.minute(), doubleValue: 0.0)
    
///    Todays calories goals
    @State var totalCalories: [Double]
    @State private var todaysCalories: Double = 0.0
    @State private var todaysCaloriesGoal: Double = 0.0
    @State private var todaysCalorieGoal: HKQuantity = HKQuantity.init(unit: HKUnit.kilocalorie(), doubleValue: 0.0)
    
    @State private var pastWeek: [String] = []
    
    var body: some View {
        ZStack (alignment: .topLeading){
            gradient.backgroundGradient
                .ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Health").font(.largeTitle).bold()
                    .padding()
                HStack(alignment: .firstTextBaseline) {
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading){
                            Text("Sleep").font(.title2).bold()
                            Text(String(format: "Score: %.2f", 0.30343))
                                .font(.subheadline)
                            Text("Hrs: 10hrs")
                                .font(.subheadline)
                        }
                        Image(systemName: "bed.double.fill")
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
                    .frame(maxWidth: .infinity)
                    .background(ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(gradient.defaultSleepGradient)
                    })
                    
                    Spacer()
                    HStack(alignment: .firstTextBaseline){
                        VStack(alignment: .leading){
                            Text("Mood").font(.title2).bold()
                            Text(moodss != "none" ? "Overall: " + moodss : "Overall: -").font(.subheadline)
                            Text(" ")
                                .font(.subheadline)
                        }
                        
                        Image(systemName: "person.fill")

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
                    .frame(maxWidth: .infinity)
                    .background(ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(moodColour)
                    })
                }
                .padding()
            
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Text("Goals").font(.title).bold()
                            .padding(.leading, 5)
                            .frame(alignment: .leading)
                        HStack(alignment: .firstTextBaseline) {
                            HStack(alignment: .firstTextBaseline) {
                                VStack(alignment: .leading){
                                    Text("Exercise").font(.title2)
                                    Text("\(Int(todaysExercise))/" + "\(exerciseGoal)").font(.title).bold()
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Image(systemName: "figure.run")
                                    .imageScale(.small)
                                Text("  ")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(todaysExercise.isLess(than: todaysExerciseGoal) ? gradient.exerciseGoalNotAchieved : gradient.exerciseGoalAchieved)
                            })
                            
                            Spacer()
                            
                            HStack(alignment: .firstTextBaseline){
                                VStack(alignment: .leading){
                                    Text("Calories").font(.title2)
                                    Text("\(Int(todaysCalories))/" + "\(todaysCalorieGoal)").font(todaysCaloriesGoal > 1000 ? .title2 : .title).bold()
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Image(systemName: "fork.knife")
                                    .imageScale(.small)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(todaysCalories.isLess(than: todaysCaloriesGoal) ? gradient.calorieGoalNotAchieved : gradient.calorieGoalAchieved)
                            })
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading){
                        Text("Exercise (Past 7 Days)").bold()
                        Chart {
                            ForEach(exercise) { exercise in
                                BarMark(
                                    x: .value("Day", exercise.day),
                                    y: .value("Total Exercise Minutes", exercise.exercise)
                                )
                                .foregroundStyle(by: .value("Shape Color", exercise.colour))
                            }
                        }
                        .chartForegroundStyleScale([
                            "Exercise (mins)": .blue
                        ])
                        .chartXAxis{
                            AxisMarks(values: exerciseDate) {day in
                                if let date = day.as(String.self){
                                    AxisValueLabel{
                                        VStack(alignment: .leading){
                                            Text(date)
                                        }
                                    }
                                }
                                AxisGridLine().foregroundStyle(.white)
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(values: .automatic(desiredCount: 10)){
                                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.2)).foregroundStyle(.white)
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .frame(width: 350, height: 200)
                    
                    VStack(alignment: .leading){
                        Text("Calories (Past 7 Days)").bold()
                        Chart {
                            ForEach(calories) { calorie in
                                BarMark(
                                    x: .value("Day", calorie.day),
                                    y: .value("Total Calories", calorie.calories)
                                )
                                .foregroundStyle(by: .value("Shape Color", calorie.colour))
                            }
                        }
                        .chartForegroundStyleScale([
                            "Calories (kcal)": .red
                        ])
                        .chartXAxis{
                            AxisMarks(values: calorieDate) {day in
                                if let date = day.as(String.self){
                                    AxisValueLabel{
                                        VStack(alignment: .leading){
                                            Text(date)
                                        }
                                    }
                                }
                                AxisGridLine().foregroundStyle(.white)
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }
                        .chartYAxis {
                            AxisMarks{
                                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.2)).foregroundStyle(.white)
                                AxisValueLabel()
                                    .foregroundStyle(.white)
                            }
                        }

                    }
                    .frame(width: 350, height: 200)
                }
            }
            .foregroundStyle(.white)
            .onAppear(perform: fetchLogs)
            .onAppear {
                Task{
                    await healthKit()
                }
            }
            //            .onAppear(perform: getModel)
        }
    }
    
    func fetchLogs(){
        let predicate = Log.predicate(allEntries: false, searchDate: Date.now, chosenMood: "none")
        let fetchDescriptor = FetchDescriptor<Log>(predicate: predicate)
        var totalAlcoholFetchValue = 0.0
        var totalCaffeineFetchValue = 0.0
        var mood: [String] = []
        
///     clear all fetch values during load
        totalAlcoholValue = 0.0
        totalCaffeineValue = 0.0
        mood.removeAll()
        set.removeAllObjects()
        
        do {
            try modelContext.delete(model: Log.self, where: #Predicate { log in
                log.entry.isEmpty})
        }
        catch{
            print("Failed to delete empty logs.")
        }
        
        do {
            try modelContext.enumerate(fetchDescriptor) {log in
                totalCaffeineFetchValue += log.caffeine.caffeineBeverageTypeAmountValue
                totalAlcoholFetchValue += log.alcohol.alcoholBeverageTypeAmountValue
                if log.mood != "none"{
                    mood.append(log.mood)
                }
                print(totalAlcoholFetchValue)
                print(totalCaffeineFetchValue)
                print(mood)
                
                totalAlcoholValue = totalAlcoholFetchValue
                totalCaffeineValue = totalCaffeineFetchValue
            }
        } catch {
            print("Failed to calculate log results.")
        }
        let mappedItems = mood.map { ($0, 1) }
        let counts = Dictionary(mappedItems, uniquingKeysWith: +)
        let max_mood = counts.max { $0.value < $1.value }

        moodss = max_mood?.key ?? "none"
        print(moodss)
        
        ///get moodstatus if, no value, use none case, then set if case returns to case string else to empty case string
        moodColour = getMoodStatus(mood: Mood(rawValue: moodss) ?? Mood.none) ?? LinearGradient.init(colors: [Color.purple], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 0.0))
        print(moodColour)
        print(moods)
        
        print("Total alcohol: \(totalAlcoholValue)")
        print("Total caffeine: \(totalCaffeineValue)")
    }
    
    func getMoodStatus(mood: Mood) -> LinearGradient?{
        switch mood{
        case .none:
            return gradient.defaultMoodGradient
        case .🙁:
            return gradient.verySadMoodGradient
        case .😕:
            return gradient.sadMoodGradient
        case .😐:
            return gradient.contentMoodGradient
        case .🙂:
            return gradient.happyMoodGradient
        case .😁:
            return gradient.veryHappyMoodGradient
        }
    }
    
    func healthKit() async{
        do {
            // Check that Health data is available on the device.
            if HKHealthStore.isHealthDataAvailable() {
                let healthStore = HKHealthStore()
                
                // Create the HealthKit data types your app
                // needs to read and write.
                let toShare: Set = [
                    HKQuantityType(.activeEnergyBurned)
                ]
                
                let toRead: Set = [
                    HKQuantityType(.activeEnergyBurned),
                    HKQuantityType(.appleExerciseTime),
                    HKActivitySummaryType.activitySummaryType()
                ]
                                
                // Asynchronously request authorization to the data.
                try await healthStore.requestAuthorization(toShare: toShare, read: toRead)

                //check authorisation status
                let activeEneryBurned = healthStore.authorizationStatus(for: HKQuantityType(.activeEnergyBurned))
                switch activeEneryBurned{
                case .notDetermined:
                    sharing = .notDetermined
                case .sharingDenied:
                    sharing = .sharingDenied
                case .sharingAuthorized:
                    sharing = .sharingAuthorized
                    calories.removeAll()
                    // Create a predicate for this week's samples.
                    let calendar = Calendar(identifier: .gregorian)
                    let today = calendar.startOfDay(for: Date())

                    guard let endDate = calendar.date(byAdding: .day, value: 1, to: today) else {
                        fatalError("*** Unable to calculate the end time ***")
                    }

                    guard let startDate = calendar.date(byAdding: .day, value: -7, to: endDate) else {
                        fatalError("*** Unable to calculate the start time ***")
                    }
                    
                    let thisWeek = HKQuery.predicateForSamples(withStart: startDate, end: endDate)

                    // Create the query descriptor.
                    let activeEnergyType = HKQuantityType(.activeEnergyBurned)
                    let activeEnergyBurnedThisWeek = HKSamplePredicate.quantitySample(type: activeEnergyType, predicate:thisWeek)
                    let everyDay = DateComponents(day:1)

                    let sumOfActiveEnergyBurnedQuery = HKStatisticsCollectionQueryDescriptor(
                        predicate: activeEnergyBurnedThisWeek,
                        options: .cumulativeSum,
                        anchorDate: endDate,
                        intervalComponents: everyDay)
                    
                    let activeEnergy = try await sumOfActiveEnergyBurnedQuery.result(for: healthStore)
                    // Iterate through the statistics
                    
                        activeEnergy.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                            let date = statistics.startDate
                            var dateString = dateFormatter.string(from: date)
                            
                            let totalCalories = statistics.sumQuantity()?.doubleValue(for: HKUnit.kilocalorie()) ?? 0.0
                            
                            if date < Date(){
                                if date == today{
                                    dateString = "Today"
                                }
                                calories.append(Calories(day: dateString, calories: totalCalories, colour: "Calories (kcal)"))
                                calorieDate.append(dateString)
                            }
                            
                            if date == today{
                                todaysCalories = totalCalories
                            }
                        }
                    
                @unknown default:
                    sharing = .notDetermined
                }
                
                let calendar = Calendar(identifier: .gregorian)
                let today = calendar.startOfDay(for: Date())
                
                guard let endDate = calendar.date(byAdding: .day, value: 1, to: today) else {
                    fatalError("*** Unable to calculate the end time ***")
                }

                guard let startDate = calendar.date(byAdding: .day, value: -7, to: endDate) else {
                    fatalError("*** Unable to calculate the start time ***")
                }
                
                exercise.removeAll()
                // Create the query descriptor.
                let thisWeek = HKQuery.predicateForSamples(withStart: startDate, end: endDate)

                let exerciseTime = HKQuantityType(.appleExerciseTime)
                
                let exerciseTimeThisWeek = HKSamplePredicate.quantitySample(type: exerciseTime, predicate:thisWeek)
                
                let everyDay = DateComponents(day:1)

                let sumOfExerciseMinutesQuery = HKStatisticsCollectionQueryDescriptor(
                    predicate: exerciseTimeThisWeek,
                    options: .cumulativeSum,
                    anchorDate: endDate,
                    intervalComponents: everyDay)

                let exerciseMinutes = try await sumOfExerciseMinutesQuery.result(for: healthStore)
                // Iterate through the statistics
                    exerciseMinutes.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                        let date = statistics.startDate
                        var dateString = dateFormatter.string(from: date)
                        
                        let exerciseMinutes = statistics.sumQuantity()?.doubleValue(for: HKUnit.minute()) ?? 0.0
                        if date < Date(){
                            if date == today{
                                dateString = "Today"
                            }
                            exercise.append(Exercise(day: dateString, exercise: exerciseMinutes, colour: "Exercise (mins)"))
                            exerciseDate.append(dateString)
                            print(exerciseDate)
                        }
                        
                        if date == today{
                            todaysExercise = exerciseMinutes
                        }
                    }

                let summaryCalendar = NSCalendar.current
                let summaryEndDate = Date()
                 
                guard let startDate = calendar.date(byAdding: .day, value: -7, to: summaryEndDate) else {
                    fatalError("*** Unable to create the start date ***")
                }

                let units: Set<Calendar.Component> = [.day, .month, .year, .era]

                var startDateComponents = calendar.dateComponents(units, from: startDate)
                startDateComponents.calendar = summaryCalendar

                var endDateComponents = calendar.dateComponents(units, from: summaryEndDate)
                endDateComponents.calendar = summaryCalendar

                // Create the predicate for the query
                let summariesWithinRange = HKQuery.predicate(forActivitySummariesBetweenStart: endDateComponents,
                                                             end: endDateComponents)
                
                let query = HKActivitySummaryQuery(predicate: summariesWithinRange) { (query, summariesOrNil, errorOrNil) -> Void in
                    guard let summaries = summariesOrNil else {
                        return
                    }
                    DispatchQueue.main.async {
                        exerciseGoal = summaries.first?.exerciseTimeGoal ?? HKQuantity.init(unit: HKUnit.minute(), doubleValue: 0.0)
                        todaysExerciseGoal = summaries.first?.exerciseTimeGoal?.doubleValue(for: HKUnit.minute()) ?? 0.0
                        todaysCalorieGoal = summaries.first?.activeEnergyBurnedGoal ?? HKQuantity.init(unit: HKUnit.kilocalorie(), doubleValue: 0.0)
                        todaysCaloriesGoal = todaysCalorieGoal.doubleValue(for: HKUnit.kilocalorie())
                    }
                }
                healthStore.execute(query)
            }
        } catch {
            // Typically, authorization requests only fail if you haven't set the
            // usage and share descriptions in your app's Info.plist, or if
            // Health data isn't available on the current device.
            fatalError("*** An unexpected error occurred while requesting authorization: \(error.localizedDescription) ***")
        }
    }
        
    
    func getModel(){
        //converting string values to their corresponding double values trained in the ML model
        var genderToML = 0
        var sleepHourToML = 0.0
        var sleepMinuteToML = 0.0
        var sleepGoalToML = 0.0
        var rem_Sleep = 0.0
        var deep_Sleep = 0.0
        var sleep_Awakenings = 0.0
        var smoking_Status = 0.0
        
        //male = 0, female = 1 in model
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


//#Preview {
//    HealthView()
//}








