import SwiftUI

struct SetReminderView: View {
    private var plant: Plant?
    @Environment(\.dismiss) var dismiss
    @State private var shouldNavigateToReminder = false
    @ObservedObject var viewModel: PlantViewModel
    init(plant: Plant? = nil, viewModel: PlantViewModel) {
        self.plant = plant ?? Plant(name: "", room: "", light: "", wateringFrequency: "", waterAmount: "")
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Section 1: Plant Name
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $viewModel.plantName)
                    }.frame(height: 37)
                }
                
                // Section 2: Room and Light
                Section {
                    // Room Picker with Icon
                    Picker(selection: $viewModel.room, label: HStack {
                        Image(systemName: "location")
                        Text("Room")
                    }) {
                        ForEach(viewModel.rooms, id: \.self) { room in
                            Text(room)
                                .foregroundColor(room == viewModel.rooms.first ? .gray : .primary)
                        }
                    }
                    
                    // Light Picker with Icon
                    Picker(selection: $viewModel.light, label: HStack {
                        Image(systemName: "sun.max")
                        Text("Light")
                    }) {
                        ForEach(viewModel.lights, id: \.self) { light in
                            Text(light)
                                .foregroundColor(light == viewModel.lights.first ? .gray : .primary)
                        }
                    }
                }
                
                // Section 3: Watering Frequency and Water Amount
                Section {
                    // Watering Days Picker with Icon
                    Picker(selection: $viewModel.wateringFrequency, label: HStack {
                        Image(systemName: "drop")
                        Text("Watering Days")
                    }) {
                        ForEach(viewModel.wateringFrequencies, id: \.self) { frequency in
                            Text(frequency)
                                .foregroundColor(frequency == viewModel.wateringFrequencies.first ? .gray : .primary)
                        }
                    }
                    
                    // Water Amount Picker with Icon
                    Picker(selection: $viewModel.waterAmount, label: HStack {
                        Image(systemName: "drop")
                        Text("Water Amount")
                    }) {
                        ForEach(viewModel.waterAmounts, id: \.self) { amount in
                            Text(amount)
                                .foregroundColor(amount == viewModel.waterAmounts.first ? .gray : .primary)
                        }
                    }
                }
                Section {
                    Button("Delete Reminder") {
                        if let plant = plant {
                            print("Deleting plant with ID: \(plant.id)")
                            viewModel.deletePlant(plant)
                        }
                        dismiss()
                    }
                    .frame(width: 396, height: 36)
                    .cornerRadius(10)
                    .foregroundColor(Color(red: 234/255, green: 113/255, blue: 102/255))
                    .font(.system(size: 20))
                }
            }.listSectionSpacing(20)
                .navigationTitle("Set Reminder")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        navigationButton("Cancel", action: { dismiss() })
                    }
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        navigationButton("Save") {
                            if let plant = plant {
                                viewModel.savePlant() // Save or update the plant in UserDefaults
                            }
                            dismiss() // Close the view after saving
                        }
                    }
                }
                .navigationDestination(isPresented: $shouldNavigateToReminder) {
                    TodayReminderView(viewModel: viewModel)
                }
        }
        .onDisappear {
            if !viewModel.plantName.isEmpty {
                viewModel.savePlant()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Helper function for the buttons
    private func navigationButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
            .font(title == "Save" ? .body.bold() : .body)
    }
}

#Preview {
    let samplePlant = Plant(
        name: "Pothos",
        room: "Living Room",
        light: "Indirect Light",
        wateringFrequency: "Weekly", waterAmount: "50-100 ml"
    )
    
    let sampleViewModel = PlantViewModel()
    
    return SetReminderView(plant: samplePlant, viewModel: sampleViewModel)
}
