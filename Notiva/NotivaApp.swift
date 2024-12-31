//
//  NotivaApp.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

@main
struct NotivaApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var showingOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
