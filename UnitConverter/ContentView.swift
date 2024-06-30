//
//  ContentView.swift
//  UnitConverter
//
//  Created by Billy Baney on 6/29/24.
//

// Create a converter app that changes the temperature from the desired unit to another unit
// Declare a variable to hold the current temperature
//      Let users choose what the current unit of measurement is
// Make a way to be able to take the users current unit and take their selected unit and convert it
//      Display that converted temperature to the user

import SwiftUI

struct ContentView: View {
    // Declare a variable to hold current temperature
    @State private var currentTemp = 55.0
    // Declare a variable to hold current starting unit of measurement
    @State private var unitOfMeasurement = "Fahrenheit"
    @State private var convertedMeasurement = "Celsius"
    
    @FocusState private var tempIsFocused: Bool
    
    func changeFromF() -> Double {
        let toC = (currentTemp - 32) * 5/9
        let toF = (currentTemp - 32) * 5/9 + 273.15
        if convertedMeasurement == "Celsius" && unitOfMeasurement == "Fahrenheit" {
            return round(toC * 10) / 10
        } else if convertedMeasurement == "Kelvin" && unitOfMeasurement == "Fahrenheit" {
            return round(toF * 10) / 10
        }
        return currentTemp
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Current Temperature") {
                    // create an input so users can put in their current temperature they want converted
                    TextField("Current Temperature", value: $currentTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                    
                    // Let users select their current unit of measurement
                    Picker("Current Unit: ", selection: $unitOfMeasurement) {
                        ForEach(["Fahrenheit", "Celsius", "Kelvin"], id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Picker("Desired Unit: ", selection: $convertedMeasurement) {
                        ForEach(["Fahrenheit", "Celsius", "Kelvin"], id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Converted Temperature: ") {
                    Text(changeFromF(), format: .number)
                }
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                if tempIsFocused {
                    Button("Done") {
                        tempIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
