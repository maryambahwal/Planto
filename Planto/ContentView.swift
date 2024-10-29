//
//  ContentView.swift
//  Planto
//
//  Created by Maryam Bahwal on 19/04/1446 AH.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var plantViewModel = PlantViewModel()
    var body: some View {
        if plantViewModel.plants.isEmpty {
            StartView(viewModel: plantViewModel) // Display the "Start" page if no plants are present
        } else {
            TodayReminderView(viewModel: plantViewModel) // Display the "Today Reminder" page if there are plants
        }
    }
}

#Preview {
    ContentView()
}
