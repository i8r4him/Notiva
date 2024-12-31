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
                
                // In App Purchases
                Section(header: Text("In-App Purchases")) {
                    NavigationLink(destination: Text("In-App Purchases")) {
                        Label("Your subscriptions", systemImage: "bag.fill.badge.plus")
                    }
                    
                    NavigationLink(destination: Text("Manage Subscriptions")) {
                        Label("Customer Center", systemImage: "person.2.fill")
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
                    NavigationLink(destination: Text("General")) {
                        Label("General", systemImage: "slider.horizontal.below.square.and.square.filled")
                    }
                    NavigationLink(destination: Text("More")) {
                        Label("Cloud & Backup", systemImage: "externaldrive.fill.badge.icloud")
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
                    NavigationLink(destination: Text("Request a Feature")) {
                        Label("Request a Feature", systemImage: "exclamationmark.bubble.fill")
                    }
                    NavigationLink(destination: Text("Help & Feedback")) {
                        Label("Help & Feedback", systemImage: "questionmark.bubble.fill")
                    }
                    NavigationLink(destination: Text("Follow Me")) {
                        Label("Follow Me", systemImage: "person.2.fill")
                    }
                    NavigationLink(destination: Text("About")) {
                        Label("About", systemImage: "bookmark.fill")
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
                    VStack(spacing: 8) {
                        Text("Made with ❤️ by Ibrahim")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Text("Version 1.0")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Link("@i8r4him", destination: URL(string: "https://twitter.com/i8r4him")!)
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
           .environment(\.symbolRenderingMode, .hierarchical)
            .sheet(isPresented: $viewModel.showTipView) {
                TipView()
                    //.presentationDetents([.medium])
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    SettingsView()
}
