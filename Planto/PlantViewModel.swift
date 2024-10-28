//  PlantViewModel.swift
//  Planto
//  Created by Maryam Bahwal on 19/04/1446 AH.

import Foundation
class PlantViewModel: ObservableObject {
    @Published var plantName: String = ""
    
    @Published var room: String = "Bedroom"
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    
    @Published var light: String = "Full Sun"
    let lights = ["Full Sun", "Partial Sun", "Low Light"]
    
    
    @Published var wateringFrequency: String = "Every day"
    let wateringFrequencies = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    
    
    @Published var waterAmount: String = "20-50 ml"
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    
    @Published var plants: [Plant] = [
        
        //        Plant(name: "Pothos", room: "Bedroom", light: "Full sun", wateringFrequency: "Every 3 days", waterAmount: "20-50 ml"),
        //        Plant(name: "Monstera", room: "Kitchen", light: "Full sun", wateringFrequency: "Once a week" , waterAmount: "20-50 ml")
        
    ]
    
    // When the view model is initialized, load the saved plants
    init() {
        loadPlants()
    }
    
    // Save plant info when the user adds a new plant
    func savePlant() {
        let plant = Plant(name: plantName, room: room, light: light, wateringFrequency: wateringFrequency, waterAmount: waterAmount)
        plants.append(plant)
        savePlants()  // Persist plants to UserDefaults
        print("Plant saved: \(plant)")
    }
    
    // Toggle the check status of a plant
    func toggleCheck(for plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isChecked.toggle()
            objectWillChange.send()  // Notify view to update after the state change
            savePlants()  // Save updated plants to UserDefaults
        }
    }
    
    // MARK: - Persistence Methods
    
    // Save plants to UserDefaults
    private func savePlants() {
        let encoder = JSONEncoder()
        if let encodedPlants = try? encoder.encode(plants) {
            UserDefaults.standard.set(encodedPlants, forKey: "savedPlants")
        }
    }
    
    // Load plants from UserDefaults
    private func loadPlants() {
        if let savedPlants = UserDefaults.standard.data(forKey: "savedPlants") {
            let decoder = JSONDecoder()
            if let decodedPlants = try? decoder.decode([Plant].self, from: savedPlants) {
                self.plants = decodedPlants
            }
        }
    }
    func deletePlants(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
        savePlants()  // Persist the updated list to UserDefaults
    }
}
