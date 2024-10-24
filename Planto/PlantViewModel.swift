//
//  PlantViewModel.swift
//  Planto
//
//  Created by Maryam Bahwal on 19/04/1446 AH.
//

import Foundation
class PlantViewModel: ObservableObject {
    @Published var plantName: String = ""
    
    @Published var room: String = "Bedroom"
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    
    
//    @Published var light: Light = .fullSun
//    let lights: [Light] = Light.allCases
    //
    @Published var light: String = "Full Sun"
    let lights = ["Full Sun", "Partial Sun", "Low Light"]
    
//    @Published var wateringFrequency: WateringFrequency = .everyDay
//    let wateringFrequencies: [WateringFrequency] = [
//        .everyDay,
//        .every2Days,
//        .every3Days,
//        .onceAWeek,
//        .every10Days,
//        .every2Weeks
//    ]
    @Published var wateringFrequency: String = "Every day"
    let wateringFrequencies = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    
    
//    @Published var waterAmount: WaterAmount = .small
//    let waterAmounts: [WaterAmount] = WaterAmount.allCases
    @Published var waterAmount: String = "20-50 ml"
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    
    @Published var plants: [Plant] = [
        
        Plant(name: "Pothos", room: "Bedroom", light: "Full sun", wateringFrequency: "Every 3 days", waterAmount: "20-50 ml"),
                Plant(name: "Monstera", room: "Kitchen", light: "Full sun", wateringFrequency: "Once a week" , waterAmount: "20-50 ml")
            
    ] // Plant data will be stored here
    
    // You can add functions here to add, remove, or modify plants in this array
    func savePlant() {
        // Logic to save the plant data
        let plant = Plant(name: plantName,
                          room: room,
                          light: light,
                          wateringFrequency: wateringFrequency,
                          waterAmount: waterAmount)
        plants.append(plant)
        print("Plant saved: \(plant)")
        // Here you can implement saving the plant, e.g., to a database or user defaults
    }
    
    
    func toggleCheck(for plant: Plant) {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                plants[index].isChecked.toggle()
                objectWillChange.send()  // Notify view to update after the state change
            }
        }
}
