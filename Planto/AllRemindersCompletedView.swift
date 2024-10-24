//
//  AllRemindersCompletedView.swift
//  Planto
//
//  Created by Maryam Bahwal on 20/04/1446 AH.
//

import SwiftUI
extension Color {
    static let customColor = Color(red: 234/255, green: 234/255, blue: 215/255)
}
struct AllRemindersCompletedView: View {
    var body: some View {
        VStack {
            Image("ReminderCompleted").padding(.top, 80).padding(.bottom, 30)
                
            Text("All Done! 🎉").padding(.bottom, 14).font(.system(size: 25)).bold().foregroundColor(Color.customColor)
                
            
            Text("All Reminders Completed").foregroundColor(.gray).font(.system(size: 16)).padding(.bottom, 217)
                
        }
        .frame(maxWidth: .infinity, alignment: .center)
//        .padding()
    }
}

#Preview {
    AllRemindersCompletedView()
}
