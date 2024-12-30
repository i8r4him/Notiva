//
//  ContentView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            
            Tab("Calendar", systemImage: "calendar") {
                CalendarView()
            }
            
            Tab("Focus", systemImage: "note.text") {
                FocusView()
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
