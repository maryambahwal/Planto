//  PlantViewModel.swift
//  Planto
//  Created by Maryam Bahwal on 19/04/1446 AH.

import Foundation
class PlantViewModel: ObservableObject {
    @Published var plantName: String = ""
    @Published var selectedPlant: Plant?
    
    @Published var room: String = "Bedroom"
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    
    @Published var light: String = "Full Sun"
    let lights = ["Full Sun", "Partial Sun", "Low Light"]
    
    
    @Published var wateringFrequency: String = "Every day"
    let wateringFrequencies = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    
    
    @Published var waterAmount: String = "20-50 ml"
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    
    @Published var plants: [Plant] = []
    
    // When the view model is initialized, load the saved plants
    init() {
        loadPlants()
    }
    
    func deletePlant(_ plant: Plant) {
        print("Attempting to delete plant: \(plant.name) with ID: \(plant.id)")
        print("Current plants: \(plants.map { "\($0.name) with ID: \($0.id)" })") // Log current plants before deletion
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            print("Found plant at index: \(index)")
            plants.remove(at: index)
            savePlants()  // Persist the updated list to UserDefaults
        } else {
            print("Plant not found in the array with ID: \(plant.id)")
        }
    }
    
    func savePlant() {
        if let selectedPlant = selectedPlant, let index = plants.firstIndex(where: { $0.id == selectedPlant.id }) {
            // Edit the existing plant
            plants[index].name = plantName
            plants[index].room = room
            plants[index].light = light
            plants[index].wateringFrequency = wateringFrequency
            plants[index].waterAmount = waterAmount
        } else {
            // Add a new plant
            let newPlant = Plant(
                name: plantName,
                room: room,
                light: light,
                wateringFrequency: wateringFrequency,
                waterAmount: waterAmount
            )
            plants.append(newPlant)
        }
        savePlants() // Save changes to UserDefaults
        clearFormFields() // Clear fields after saving
    }
    
    // Clear fields after saving or when preparing a new plant
    func clearFormFields() {
        plantName = ""
        room = rooms.first ?? ""
        light = lights.first ?? ""
        wateringFrequency = wateringFrequencies.first ?? ""
        waterAmount = waterAmounts.first ?? ""
        selectedPlant = nil
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
    
    private func loadPlants() {
        if let savedPlants = UserDefaults.standard.data(forKey: "savedPlants") {
            let decoder = JSONDecoder()
            if let decodedPlants = try? decoder.decode([Plant].self, from: savedPlants) {
                self.plants = decodedPlants
                print("Plants loaded successfully: \(plants.map { "\($0.name) with ID: \($0.id)" })")
            } else {
                print("Failed to decode plants")
            }
        } else {
            print("No saved plants found in UserDefaults")
        }
    }
}
