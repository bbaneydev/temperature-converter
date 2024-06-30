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
    @State private var currentTemp = 55.0
    @State private var unitOfMeasurement = "Fahrenheit"
    @State private var convertedMeasurement = "Celsius"
    
    @FocusState private var tempIsFocused: Bool
    
    func changeFromF() -> Double {
        let toC = (currentTemp - 32) * 5/9
        let toK = (currentTemp - 32) * 5/9 + 273.15
        if convertedMeasurement == "Celsius" && unitOfMeasurement == "Fahrenheit" {
            return round(toC * 10) / 10
        } else if convertedMeasurement == "Kelvin" && unitOfMeasurement == "Fahrenheit" {
            return round(toK * 10) / 10
        }
        return currentTemp
    }
    
    func changeFromC() -> Double {
        let toF = (currentTemp * 9/5) + 32
        let toK = (currentTemp + 273.15)
        if unitOfMeasurement == "Celsius" && convertedMeasurement == "Fahrenheit" {
            return round(toF * 10) / 10
        } else if unitOfMeasurement == "Celsius" && convertedMeasurement == "Kelvin" {
            return round(toK * 10) / 10
        }
        return currentTemp
    }
    
    func changeFromK() -> Double {
        let toF = (currentTemp - 273.15) * 9/5 + 32
        let toC = (currentTemp - 273.15)
        if unitOfMeasurement == "Kelvin" && convertedMeasurement == "Fahrenheit" {
            return round(toF * 10) / 10
        } else if unitOfMeasurement == "Kelvin" && convertedMeasurement == "Celsius" {
            return round(toC * 10) / 10
        }
        return currentTemp
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Current Temperature") {
                    TextField("Current Temperature", value: $currentTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                    
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
                    if unitOfMeasurement == "Fahrenheit" {
                        Text(changeFromF(), format: .number)
                    } else if unitOfMeasurement == "Celsius" {
                        Text(changeFromC(), format: .number)
                    } else {
                        Text(changeFromK(), format: .number)
                    }
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
