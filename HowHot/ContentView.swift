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
                return celToFah(fromTemp)
            } else if toScale == "Kelvin" {
                return celToKel(fromTemp)
            } else {
                return fromTemp
            }
        } else if fromScale == "Fahrenheit" {
            if toScale == "Celsius" {
                return fahToCel(fromTemp)
            } else if toScale == "Kelvin" {
                return celToKel(fahToCel(fromTemp))
            } else {
                return fromTemp
            }
        } else {
            if toScale == "Celsius" {
                return kelToCel(fromTemp)
            } else if toScale == "Fahrenheit" {
                return celToFah(kelToCel(fromTemp))
            } else {
                return fromTemp
            }
        }
    }
    
    private func fahToCel(_ fah: Double) -> Double {
        return (fah - 32.0) * 5.0 / 9.0
    }
    
    private func celToFah(_ cel: Double) -> Double {
        return cel * 9.0 / 5.0 + 32.0
    }
    
    private func celToKel(_ cel: Double) -> Double {
        return cel + 273.15
    }
    
    private func kelToCel(_ kel: Double) -> Double {
        return kel - 273.15
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
