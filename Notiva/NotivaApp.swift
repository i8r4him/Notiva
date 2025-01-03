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
            let schema = Schema([Major.self, User.self])
            
            // Configure the container
            let config = ModelConfiguration("Notiva", schema: schema)
            
            // Create and return container
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            // If container creation fails, use in-memory container
            fatalError("Could not configure SwiftData container")
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
