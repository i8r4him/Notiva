//
//  HomeView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct HomeView: View {
    @State private var isSettingsSheetPresented = false

    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "house", description: Text("Not yet implemented"))
                .navigationTitle("Home")
                .toolbar {
                    // Conditionally add the toolbar item for iPad devices only
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isSettingsSheetPresented = true
                            }) {
                                Image(systemName: "gearshape")
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                }
                .sheet(isPresented: $isSettingsSheetPresented) {
                    SettingsView()
                }
        }
    }
}

#Preview {
    HomeView()
}
