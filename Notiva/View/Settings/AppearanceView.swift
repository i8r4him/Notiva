//
//  AppearanceView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 31.12.24.
//

import SwiftUI

struct AppearanceView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        Form {
            Section(header: Text("Display Mode")) {
                Picker("Mode", selection: $viewModel.selectedLightDarkOrSystem) {
                    ForEach(LightDarkOrSystem.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            }
            Section(header: Text("Main Color")) {
                Picker("Main Color", selection: $viewModel.selectedColorScheme) {
                    ForEach(ColorSchemeOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            }
        }
        .navigationTitle("Appearance")
    }
}

#Preview {
    AppearanceView(viewModel: SettingsViewModel())
}
