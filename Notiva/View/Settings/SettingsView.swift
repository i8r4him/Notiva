//
//  SettingsView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            List {
                // Profile Section
                Section {
                    NavigationLink(destination: Text("User Profile")) {
                        ProfileHeaderView()
                    }
                }

                // Premium Upgrade
                Section {
                    PremiumUpgradeRow {
                        viewModel.handlePremiumUpgrade() // TODO: Connect to upgrade logic
                    }
                }

                // Focus Timer
                Section {
                    NavigationLink(destination: Text("Focus Timer")) {
                        Label("Focus Timer", systemImage: "timer")
                    }
                }

                // User Preferences
                Section(header: Text("User Preferences")) {
                    NavigationLink(destination: AppearanceView(viewModel: viewModel)) {
                        Label("Appearance", systemImage: "paintpalette.fill")
                    }
                    NavigationLink(destination: Text("Sounds & Notifications")) {
                        Label("Sounds & Notifications", systemImage: "bell.badge.fill")
                    }
                    NavigationLink(destination: Text("Date & Time")) {
                        Label("Date & Time", systemImage: "calendar.badge.clock")
                    }
                    NavigationLink(destination: Text("Widgets")) {
                        Label("Widgets", systemImage: "widget.small.badge.plus")
                    }
                    NavigationLink(destination: Text("General")) {
                        Label("General", systemImage: "slider.horizontal.below.square.and.square.filled")
                    }
                }

                // Integration
                Section(header: Text("Integration")) {
                    NavigationLink(destination: Text("Import & Integration")) {
                        Label("Import & Integration", systemImage: "arrowshape.turn.up.right.circle.fill")
                    }
                }

                // Help & Feedback
                Section(header: Text("Help & Feedback")) {
                    NavigationLink(destination: Text("Help & Feedback")) {
                        Label("Help & Feedback", systemImage: "questionmark.bubble.fill")
                    }
                    NavigationLink(destination: Text("Follow Me")) {
                        Label("Follow Me", systemImage: "person.2.fill")
                    }
                }

                // What's New & Share
                Section(header: Text("Notiva")) {
                    NavigationLink(destination: Text("What's New")) {
                        Label("What's New", systemImage: "text.badge.star")
                    }
                    Button(action: {
                        // TODO: Share Notiva app logic here
                    }) {
                        Label("Share Notiva App", systemImage: "square.and.arrow.up.fill")
                    }
                }

                // Support the Developer
                Section(header: Text("Support the Developer")) {
                    Button(action: {
                        viewModel.showTipView = true
                    }) {
                        Label("Buy Me a Coffee", systemImage: "cup.and.heat.waves.fill")
                    }
                }

                // Footer Section
                Section {
                    Text("Made with ❤️ by Ibrahim\nVersion 1.0")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(
               UIDevice.current.userInterfaceIdiom == .phone ? .large : .inline
           )
           .environment(\.symbolRenderingMode, .hierarchical)
            .sheet(isPresented: $viewModel.showTipView) {
                TipView()
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    SettingsView()
}