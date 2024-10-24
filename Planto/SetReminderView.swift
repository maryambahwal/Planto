import SwiftUI

struct SetReminderView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = PlantViewModel()
    @State private var shouldNavigateToReminder = false
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
            }.listSectionSpacing(20)
                .navigationTitle("Set Reminder")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        navigationButton("Cancel", action: { dismiss() })
                    }
                    
                    
                    // Use NavigationDestination for navigating to TodayReminderView
//                    NavigationLink(destination: TodayReminderView(viewModel: viewModel)){
                                                    ToolbarItem(placement: .navigationBarTrailing) {
                            navigationButton("Save") {
                                viewModel.savePlant()
                                shouldNavigateToReminder = true
                            }
                        }
//                    }
                }
            
//            // Handle navigation using navigationDestination
                        .navigationDestination(isPresented: $shouldNavigateToReminder) {
                            TodayReminderView(viewModel: viewModel)
                        }
        }
       
    }
    
    // Helper function for the buttons
    private func navigationButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
            .font(title == "Save" ? .body.bold() : .body)
    }
}

#Preview {
    SetReminderView()
}
