//
//  FocusView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.10.24.
//

import SwiftUI

struct FocusView: View {
    
    @StateObject private var model = FocusViewModel()
    @State private var showTimerSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
                Button(action: {
                    vibrateButton()
                    showTimerSheet.toggle()
                }) {
                    VStack {
                        Text(model.isFocusMode ? "Focus Time 📚" : "Break Time ☕️")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(timeString(from: model.timerValue))
                            .font(.system(size: 110, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                    }
                }
                .sheet(isPresented: $showTimerSheet) {
                    TimerDuration(model: model)
                        .presentationDetents([.height(430)])
                        .presentationCornerRadius(50)
                }
                
                if model.isFocusMode {
                    Text("Minutes Focused: \(model.focusMinutesCounter)")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("Minutes Left Until Next Coin: \(10 - model.focusMinutesCounter % 10)")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        vibrateButton()
                        model.state = .cancelled
                    }) {
                        Label("Cancel", systemImage: "xmark")
                    }
                    .disabled(model.state == .cancelled)
                    
                    switch model.state {
                    case .cancelled:
                        Button(action: {
                            vibrateButton()
                            model.state = .active
                        }) {
                            Label("Start", systemImage: "play.fill")
                        }
                        
                    case .paused:
                        Button(action: {
                            vibrateButton()
                            model.state = .resumed
                        }) {
                            Label("Resume", systemImage: "arrow.clockwise")
                        }
                        
                    case .active, .resumed:
                        Button(action: {
                            vibrateButton()
                            model.state = .paused
                        }) {
                            Label("Pause", systemImage: "pause.fill")
                        }
                    }
                }
                .buttonStyle(AllButtonsStyle())
            }
            .navigationTitle("Focus")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Image(systemName: "bitcoinsign.circle.fill")
                            .foregroundColor(.yellow)
                        Text("\(model.coinsEarned)")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        SettingsButton(isSheetPresented: $showSettingsSheet)
                    }
                }
            }
        }
    }
    
    // MARK: - Utility Functions
    
    /// Converts seconds into a formatted time string (MM:SS)
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    /// Triggers a light vibration using `UIImpactFeedbackGenerator`
    func vibrateButton() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

#Preview {
    FocusView()
}
