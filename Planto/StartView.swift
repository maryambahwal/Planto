//
//  StartView.swift
//  Planto
//
//  Created by Maryam Bahwal on 19/04/1446 AH.
//

import SwiftUI

struct StartView: View {
    @State private var isSetReminderPresented = false
    var body: some View {
        VStack{
            Text("My Plants 🌱").font(.system(size: 34)).bold().frame(maxWidth: .infinity, alignment: .leading)
            Divider().frame(height:0.5).background(Color.gray).padding(.bottom, 77)
        } .padding(.leading)
        VStack{
            Image("planto").resizable().frame(width: 164, height: 200).padding(.bottom, 52)
            Text("Start your plant journey!").font(.system(size: 25)).bold().padding(.bottom, 25)
            Text("Now all your plants will be in one place and we will help you take care of them :)🪴").multilineTextAlignment(.center).frame(width: 315, height: 39).font(.system(size: 16)).foregroundColor(.gray).padding(.bottom, 25)
            Button("Set Plant Reminder") {
                isSetReminderPresented.toggle()
            }.frame(width: 280, height: 40).background(Color( red: 40/255, green: 224/255, blue: 168/255)).cornerRadius(10).foregroundColor(.black).bold().font(.system(size: 16))
                .sheet(isPresented: $isSetReminderPresented) {
                    SetReminderView()
                }
        }.frame(width: 315, height: 410).padding(.bottom,190)
    }
}

#Preview {
    StartView()
}
