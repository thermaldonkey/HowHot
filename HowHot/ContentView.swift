//
//  ContentView.swift
//  HowHot
//
//  Created by Brad Rice on 3/25/25.
//

import SwiftUI

enum TemperatureScale: CaseIterable {
    case celsius, fahrenheit, kelvin
    
    func stringValue() -> String {
        switch self {
            case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .kelvin:
            return "Kelvin"
        }
    }
}

struct ContentView: View {
    @State private var fromScale: TemperatureScale = .celsius
    @State private var toScale: TemperatureScale = .fahrenheit
    @State private var fromTemp: Double = 0.0
    
    @FocusState private var tempIsFocused: Bool
        
    private var toTemp: Double {
        switch fromScale {
        case .celsius:
            switch toScale {
            case .celsius:
                return fromTemp
            case .fahrenheit:
                return celToFah(fromTemp)
            case .kelvin:
                return celToKel(fromTemp)
            }
        case .fahrenheit:
            switch toScale {
            case .celsius:
                return fahToCel(fromTemp)
            case .fahrenheit:
                return fromTemp
            case .kelvin:
                return celToKel(fahToCel(fromTemp))
            }
        case .kelvin:
            switch toScale {
            case .celsius:
                return kelToCel(fromTemp)
            case .fahrenheit:
                return celToFah(kelToCel(fromTemp))
            case .kelvin:
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
                        ForEach(TemperatureScale.allCases, id: \.self) {
                            Text($0.stringValue())
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Degrees", value: $fromTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                }
                
                Section("To") {
                    Picker("To", selection: $toScale) {
                        ForEach(TemperatureScale.allCases, id: \.self) {
                            Text($0.stringValue())
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
