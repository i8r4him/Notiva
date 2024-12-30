//
//  SettingsView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "gearshape", description: Text("Not yet implemented"))
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(
                    UIDevice.current.userInterfaceIdiom == .phone ? .automatic : .inline
                )
        }
    }
}

#Preview {
    SettingsView()
}
