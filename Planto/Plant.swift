
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
