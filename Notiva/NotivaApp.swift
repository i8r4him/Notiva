//
//  NotivaApp.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI
import SwiftData

@main
struct NotivaApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var showingOnboarding: Bool = false
    
    // Create a single shared model container
    let container: ModelContainer = {
        do {
            // Create schema for all models
            let schema = Schema([
                Major.self,
                User.self,
                Subject.self  // Add Subject to schema
            ])
            
            // Configure the container with better error handling
            let modelConfig = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                allowsSave: true
            )
            
            // Create and return container
            return try ModelContainer(for: schema, configurations: modelConfig)
        } catch {
            // Provide better error handling with debug information
            print("SwiftData Container Error: \(error)")
            fatalError("Could not configure SwiftData container: \(error.localizedDescription)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Apply single container for all models
                .modelContainer(container)
                .sheet(isPresented: .init(
                    get: { !hasCompletedOnboarding || showingOnboarding },
                    set: { show in
                        if !show {
                            hasCompletedOnboarding = true
                            showingOnboarding = false
                        }
                    }
                )) {
                    OnboardingView()
                }
        }
    }
}
