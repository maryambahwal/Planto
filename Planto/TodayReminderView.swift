import SwiftUI

struct TodayReminderView: View {
    @ObservedObject var viewModel: PlantViewModel
    @State private var isSetReminderPresented = false
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedPlant: Plant?
    
    private var allPlantsChecked: Bool {
        viewModel.plants.allSatisfy { $0.isChecked }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                    .padding(.leading)
                
                Divider()
                    .frame(height: 0.1)
                    .foregroundColor(.blue)
                    .background(.gray)
                    .padding(.bottom, 10)
                
                if !allPlantsChecked {
                    Text("Today")
                        .font(.system(size: 28))
                        .bold()
                        .padding(.leading)
                }
                
                if allPlantsChecked {
                    AllRemindersCompletedView()
                } else {
                    plantListView
                }
                
                // New Reminder Button
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.selectedPlant = nil // Clear selectedPlant to indicate a new entry
                        viewModel.clearFormFields() // Reset fields for a new plant
                        isSetReminderPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                            Text("New Reminder")
                                .font(.headline)
                                .bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(Color(red: 40/255, green: 224/255, blue: 168/255))
                    }
                    .sheet(isPresented: $isSetReminderPresented) {
                        SetReminderView(plant: viewModel.selectedPlant, viewModel: viewModel)
                    }
                    Spacer()
                }
                .background(Color.black)
            }
            .background(Color.black.ignoresSafeArea())
        }
        .navigationBarHidden(true)
        .background(Color.black)
    }
    
    private var plantListView: some View {
        List {
            ForEach(viewModel.plants) { plant in
                plantRow(for: plant)
            }
        }
        .background(Color.black)
        .listStyle(PlainListStyle())
    }
    
    @ViewBuilder
    private func plantRow(for plant: Plant) -> some View {
        PlantRow(plant: plant, viewModel: viewModel)
            .padding(.horizontal)
            .background(Color.black)
            .listRowBackground(Color.black)
            .onTapGesture {
                viewModel.selectedPlant = plant
                viewModel.plantName = plant.name
                viewModel.room = plant.room
                viewModel.light = plant.light
                viewModel.wateringFrequency = plant.wateringFrequency
                viewModel.waterAmount = plant.waterAmount
                isSetReminderPresented = true
            }
            .sheet(item: $selectedPlant) { plant in
                SetReminderView(plant: plant, viewModel: viewModel)
            }
            .swipeActions {
                Button {
                    viewModel.deletePlant(plant)
                } label: {
                    Label("", systemImage: "trash")
                }
                .tint(.red)
            }
    }
    
    struct PlantRow: View {
        @ObservedObject var plant: Plant
        @ObservedObject var viewModel: PlantViewModel
        
        var body: some View {
            HStack {
                Button(action: {
                    viewModel.toggleCheck(for: plant)
                }) {
                    ZStack {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                            .font(.system(size: 25))
                        if plant.isChecked {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(red: 40/255, green: 224/255, blue: 168/255))
                                .font(.system(size: 25))
                        }
                    }
                    .background(Color.black)
                }
                .buttonStyle(PlainButtonStyle())
                NavigationLink(destination: SetReminderView(plant: plant, viewModel: viewModel)) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Image(systemName: "paperplane")
                                .foregroundColor(.gray)
                            Text("in \(plant.room)")
                                .foregroundColor(.gray)
                        }
                        .font(.subheadline)
                        
                        Text(plant.name)
                            .font(.system(size: 28))
                            .foregroundColor(plant.isChecked ? .gray : .white)
                            .padding(.leading, 5)
                            .padding(.bottom, 3)
                        
                        HStack(spacing: 4) {
                            HStack(spacing: 2) {
                                Image(systemName: "sun.max.fill")
                                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 133/255))
                                    .padding(.trailing, 2)
                                Text(plant.light)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 204/255, green: 199/255, blue: 133/255))
                            }
                            .padding(.trailing, 5)
                            .padding(.horizontal, 5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            
                            HStack(spacing: 2) {
                                Image(systemName: "drop")
                                    .foregroundColor(Color(red: 202/255, green: 243/255, blue: 251/255))
                                    .padding(.trailing, 2)
                                Text(plant.waterAmount)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(red: 202/255, green: 243/255, blue: 251/255))
                            }
                            .padding(.horizontal, 5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle()) // Make the whole area tappable
                    .buttonStyle(PlainButtonStyle())
                }
                .background(Color.black)
                
                Spacer()
            }
            .background(Color.black)
            .cornerRadius(10)
        }
    }
}

#Preview {
    TodayReminderView(viewModel: PlantViewModel())
}
