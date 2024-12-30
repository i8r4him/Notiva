//
//  ContentView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tabs = .home
    @AppStorage("CustomTabcustomization") private var customization: TabViewCustomization
    
    enum Tabs: String {
        case home, focus, progress, settings, calendar
        
        var customizationID: String {
            "com.createchsol.myApp.\(rawValue)"
        }
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Home", systemImage: "house", value: Tabs.home) {
                HomeView()
            }
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)

            Tab("Calendar", systemImage: "calendar", value: Tabs.calendar) {
                CalendarView()
            }
            .customizationID(Tabs.calendar.customizationID)

            Tab("Focus", systemImage: "timer", value: Tabs.focus) {
                FocusView()
            }
            .customizationID(Tabs.focus.customizationID)

            Tab("Progress", systemImage: "chart.bar", value: Tabs.progress) {
                ProgressView()
            }
            .customizationID(Tabs.progress.customizationID)

            // Conditionally include the Settings tab for iPhone devices only
            if UIDevice.current.userInterfaceIdiom == .phone {
                Tab("Settings", systemImage: "gearshape", value: Tabs.settings) {
                    SettingsView()
                }
                .customizationID(Tabs.settings.customizationID)
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($customization)
        .tabViewSidebarHeader {
            Text("Notiva")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .tabViewSidebarBottomBar {
            Label("Enjoy your App", systemImage: "app.gift")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .foregroundStyle(Color.accentColor)
        }
    }
}

#Preview {
    ContentView()
}
