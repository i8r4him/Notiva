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
                Picker("Mode",systemImage: "paintpalette.fill", selection: $viewModel.selectedLightDarkOrSystem) {
                    ForEach(LightDarkOrSystem.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            }
            
            Section(header: Text("Main Color")) {
                Picker("Main Color",systemImage: "pencil.and.outline", selection: $viewModel.selectedColorScheme) {
                    ForEach(ColorSchemeOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            }
            
            Section(header: Text("Icon appearance")) {
                NavigationLink(destination: Text("icon")) {
                    Label("Icon", systemImage: "square.dashed")
                }
            }
        }
        .navigationTitle("Appearance")
        .environment(\.symbolRenderingMode, .hierarchical)
    }
}

#Preview {
    AppearanceView(viewModel: SettingsViewModel())
}
