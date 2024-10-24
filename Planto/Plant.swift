//
//  Plant.swift
//  Planto
//
//  Created by Maryam Bahwal on 19/04/1446 AH.
//

import Foundation

// Enum to represent the water amount with display-friendly names
//enum WaterAmount: String, CaseIterable, Identifiable {
//    case small, medium, large, extraLarge
//    
//    var displayName: String {
//        switch self {
//        case .small: return "20-50 ml"
//        case .medium: return "50-100 ml"
//        case .large: return "100-200 ml"
//        case .extraLarge: return "200-300 ml"
//        }
//    }
//    
//    var id: String { self.rawValue } // Conform to Identifiable for easy use in SwiftUI Pickers
//}

// Enum to represent the watering frequency with raw values as human-readable strings
//enum WateringFrequency: String, CaseIterable, Identifiable {
//    case everyDay = "Every day"
//    case every2Days = "Every 2 days"
//    case every3Days = "Every 3 days"
//    case onceAWeek = "Once a week"
//    case every10Days = "Every 10 days"
//    case every2Weeks = "Every 2 weeks"
//    
//    var id: String { self.rawValue } // Conform to Identifiable
//}

// Enum to represent the lighting conditions of the plant
//enum Light: String, CaseIterable, Identifiable {
//    case fullSun = "Full Sun"
//    case partialSun = "Partial Sun"
//    case lowLight = "Low Light"
//    
//    var id: String { self.rawValue } // Conform to Identifiable
//}

// Struct to represent a plant with relevant properties
//struct Plant: Identifiable {
//    let id: UUID = UUID() // Unique identifier for each plant
//    let name: String // Name of the plant
//    let room: String // Room where the plant is located
////    let light: Light // Lighting conditions
////    let wateringFrequency: WateringFrequency // Watering frequency
////    let waterAmount: WaterAmount // Amount of water needed
//    let light: String // Lighting conditions
//    let wateringFrequency: String // Watering frequency
//    let waterAmount: String // Amount of water needed
//    
//    // Optional computed properties for future extensions, like custom behavior based on plant attributes
//    
//}
class Plant: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    let room: String
    let light: String
    let wateringFrequency: String // Add this line to include watering frequency
    let waterAmount: String
    @Published var isChecked: Bool
    
    init(name: String, room: String, light: String, wateringFrequency: String, waterAmount: String, isChecked: Bool = false) {
        self.name = name
        self.room = room
        self.light = light
        self.wateringFrequency = wateringFrequency // Initialize wateringFrequency
        self.waterAmount = waterAmount
        self.isChecked = isChecked
    }
    
    
}


