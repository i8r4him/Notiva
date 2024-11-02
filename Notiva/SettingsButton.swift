//
//  SettingsButton.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 08.10.24.
//

import SwiftUI

struct SettingsButton: View {
    @Binding var isSheetPresented: Bool
    var body: some View {
        Button(action: {
            isSheetPresented = true
        }) {
            Image(systemName: "gearshape")
                .foregroundColor(.accentColor)
        }
        .sheet(isPresented: $isSheetPresented) {
            SettingsView()
        }
    }
}
