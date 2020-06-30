//
//  ContentView.swift
//  BetterRest
//
//  Created by McKowen, Patrick on 6/29/20.
//  Copyright © 2020 Patrick McKowen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var idealBedtime: String {
        calculateBedtime()
    }

    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Discover your ideal bedtime based on how much coffee you drink.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Form {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.gray)
                        
                        DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .foregroundColor(.primary)
                    } .padding(.vertical, 16.0)
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Desired amount of sleep")
                        .foregroundColor(Color.gray)
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")

                        }
                    } .padding(.vertical, 8.0)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Daily coffee intake")
                        .foregroundColor(Color.gray)
                        
                        Stepper(value: $coffeeAmount, in: 1...20, step: 1) {
                            if coffeeAmount == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(coffeeAmount) cups")
                            }
                        }
                        
                    } .padding(.vertical, 8.0)
                    
                    Section {
                        VStack {
                            Text("😴")
                                .font(.largeTitle)
                                .padding(.bottom, 4)
                            Text("Your ideal bedtime is \(idealBedtime)")
                                .font(.headline)
                                .fontWeight(.medium)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    } .padding(.vertical, 16)
                }
                // end form
            }
            // end VStack
            
            .navigationBarTitle("BetterRest")
            
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Oops"), message: Text("Sorry there was a problem calculating your bedtime"), dismissButton: .default(Text("Try Again")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        let hour = (components.hour ?? 0) * 60
        let minute = (components.minute ?? 0) * 60 * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            
        } catch {
            return "Error"
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
