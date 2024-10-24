import SwiftUI

struct TodayReminderView: View {
    @ObservedObject var viewModel: PlantViewModel
    @State private var isSetReminderPresented = false
    @Environment(\.colorScheme) var colorScheme
    
    // Computed property to check if all plants are checked
    private var allPlantsChecked: Bool {
        viewModel.plants.allSatisfy { $0.isChecked }
    }
    var body: some View {
        VStack(alignment: .leading) {
            // Title Section
            Text("My Plants 🌱")
            //                .foregroundColor(Color(UIColor.label))
            //                .foregroundColor(colorScheme == .dark ? .white : .black) // Explicitly setting text color based on mode
            
                .font(.largeTitle)
                .bold()
                .padding(.top)
                .padding(.leading)
            Divider().frame(height: 0.1).foregroundColor(.blue).background(.gray).padding(.bottom, 10)
            
            if !allPlantsChecked {
                // "Today" Title
                Text("Today")
                    .font(.system(size: 28))
                    .bold()
                    .padding(.leading)
                    .padding(.top, 5)
                    .padding(.leading, 5)
            }
            // Show plant list or completion view
            if allPlantsChecked {
                AllRemindersCompletedView()
            } else {
                plantListView
            }
            //            // Plant List or Empty State
            //            plantListView
            
            
            // New Reminder Button
            HStack {
                Spacer()
                Button(action: {
                    isSetReminderPresented.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                        Text("New Reminder")
                            .font(.headline)
                            .bold()
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(Color( red: 40/255, green: 224/255, blue: 168/255))
                    
                }.sheet(isPresented: $isSetReminderPresented) {
                    SetReminderView()
                }
                Spacer()
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarHidden(true) // Remove the default back button
    }
    
    
    
    // List View for the Plants
        private var plantListView: some View {
            ScrollView {
                ForEach(viewModel.plants) { plant in
                    PlantRow(plant: plant, viewModel: viewModel)  // Pass viewModel to PlantRow
                        .padding(.horizontal)
                }
            }
        }
}

// Reusable row to display plant details
struct PlantRow: View {
    @ObservedObject var plant: Plant
    @ObservedObject var viewModel: PlantViewModel
    //    let plant: Plant
    //    @State private var isChecked = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Room info
            HStack {
                Image(systemName: "paperplane")
                    .foregroundColor(.gray)
                Text("in \(plant.room)")
                    .foregroundColor(.gray)
            }
            .font(.subheadline).padding(.leading, 30)
            
            
            HStack {
                           Button(action: {
                               viewModel.toggleCheck(for: plant)  // Use viewModel to update isChecked
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
                           }

                           Text(plant.name)
                               .font(.system(size: 28))
                               .foregroundColor(plant.isChecked ? .gray : .white)
                               .padding(.leading, 5)
                           
                           Spacer()
                       }
            
            
            
            
            // Light and Water Info
            HStack {
                Label(plant.light, systemImage: "sun.max.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Label(plant.waterAmount, systemImage: "drop")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            } .padding(.leading, 30)
        }
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
        Divider().frame(height: 0.5).foregroundColor(.blue).background(.gray).padding(.bottom, 10)
    }
}

#Preview {
    TodayReminderView(viewModel: PlantViewModel())
}
