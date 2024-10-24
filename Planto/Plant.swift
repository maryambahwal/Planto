//
//  Plant.swift
//  Planto
//
//  Created by Maryam Bahwal on 19/04/1446 AH.
//

//import Foundation

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
//class Plant: Identifiable, ObservableObject {
//    let id = UUID()
//    let name: String
//    let room: String
//    let light: String
//    let wateringFrequency: String // Add this line to include watering frequency
//    let waterAmount: String
//    @Published var isChecked: Bool
//    
//    init(name: String, room: String, light: String, wateringFrequency: String, waterAmount: String, isChecked: Bool = false) {
//        self.name = name
//        self.room = room
//        self.light = light
//        self.wateringFrequency = wateringFrequency // Initialize wateringFrequency
//        self.waterAmount = waterAmount
//        self.isChecked = isChecked
//    }
//    
//    
//}
import Foundation

class Plant: ObservableObject, Identifiable, Codable {
    var id = UUID()  // Use UUID to identify each plant
    @Published var name: String
    @Published var room: String
    @Published var light: String
    @Published var wateringFrequency: String
    @Published var waterAmount: String
    @Published var isChecked: Bool = false
    
    // Conformance to Codable
    enum CodingKeys: CodingKey {
        case id, name, room, light, wateringFrequency, waterAmount, isChecked
    }

    // Custom initializer
    init(name: String, room: String, light: String, wateringFrequency: String, waterAmount: String) {
        self.name = name
        self.room = room
        self.light = light
        self.wateringFrequency = wateringFrequency
        self.waterAmount = waterAmount
    }
    
    // Required methods for Codable conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        room = try container.decode(String.self, forKey: .room)
        light = try container.decode(String.self, forKey: .light)
        wateringFrequency = try container.decode(String.self, forKey: .wateringFrequency)
        waterAmount = try container.decode(String.self, forKey: .waterAmount)
        isChecked = try container.decode(Bool.self, forKey: .isChecked)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(room, forKey: .room)
        try container.encode(light, forKey: .light)
        try container.encode(wateringFrequency, forKey: .wateringFrequency)
        try container.encode(waterAmount, forKey: .waterAmount)
        try container.encode(isChecked, forKey: .isChecked)
    }
}


