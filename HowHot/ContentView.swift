//
//  ContentView.swift
//  HowHot
//
//  Created by Brad Rice on 3/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var fromScale: String = "Celsius"
    @State private var toScale: String = "Fahrenheit"
    @State private var fromTemp: Double = 0.0
    
    @FocusState private var tempIsFocused: Bool
    
    private let scales: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    
    private var toTemp: Double {
        if fromScale == "Celsius" {
            if toScale == "Fahrenheit" {
                return (fromTemp * 9.0 / 5.0) + 32.0
            } else if toScale == "Kelvin" {
                return fromTemp + 273.15
            } else {
                return fromTemp
            }
        } else if fromScale == "Fahrenheit" {
            if toScale == "Celsius" {
                return (fromTemp - 32.0) * 5.0 / 9.0
            } else if toScale == "Kelvin" {
                return ((fromTemp - 32.0) * 5.0 / 9.0) + 273.15
            } else {
                return fromTemp
            }
        } else {
            if toScale == "Celsius" {
                return fromTemp - 273.15
            } else if toScale == "Fahrenheit" {
                return (fromTemp - 273.15) * 9.0 / 5.0 + 32.0
            } else {
                return fromTemp
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("From") {
                    Picker("From", selection: $fromScale) {
                        ForEach(scales, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Degrees", value: $fromTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                }
                
                Section("To") {
                    Picker("To", selection: $toScale) {
                        ForEach(scales, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(toTemp, format: .number)
                }
            }
            .navigationTitle("HowHot")
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
