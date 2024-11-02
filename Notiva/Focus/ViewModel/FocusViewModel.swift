//
//  FocusViewModel.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.10.24.
//

import SwiftUI

final class FocusViewModel: ObservableObject {
    enum TimerState {
        case active
        case paused
        case resumed
        case cancelled
    }
    
    // MARK: - Private Properties
    private var timer = Timer()
    private var totalTimeForCurrentSelection: Int {
        isFocusMode ? focusDuration * 60 : breakDuration * 60
    }
    
    // MARK: - Public Properties
    @Published var focusDuration: Int = 20 { // in minutes
        didSet {
            if isFocusMode && state == .cancelled {
                timerValue = totalTimeForCurrentSelection
            }
        }
    }
    @Published var breakDuration: Int = 5 { // in minutes
        didSet {
            if !isFocusMode && state == .cancelled {
                timerValue = totalTimeForCurrentSelection
            }
        }
    }
    @Published var isFocusMode: Bool = true // true for focus, false for break
    
    @Published var timerValue: Int = 0 // total seconds remaining
    @Published var state: TimerState = .cancelled {
        didSet {
            switch state {
            case .cancelled:
                timer.invalidate()
                timerValue = totalTimeForCurrentSelection
                progress = 0
                isFocusMode = true
                focusTimeAccumulated = 0
                
            case .active:
                timerValue = totalTimeForCurrentSelection
                focusTimeAccumulated = 0 // Reset accumulated time when starting a new session
                startTimer()
                progress = 1.0
                
            case .paused:
                timer.invalidate()
                
            case .resumed:
                startTimer()
            }
        }
    }
    
    @Published var progress: Float = 0.0
    @Published var coinsEarned: Int = 0
    @Published var focusMinutesCounter: Int = 0
    
    // Variable to keep track of total focus time in seconds during a focus session
    private var focusTimeAccumulated: Int = 0
    
    /// Starts or resumes the timer, handling both focus and break durations.
    private func startTimer() {
        timer.invalidate() // Invalidate any existing timer to avoid duplicates.
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            // Use a weak reference to self to avoid retain cycles.
            guard let self = self else { return }
            
            if self.timerValue > 0 {
                self.timerValue -= 1 // Decrease the timer value by 1 second.
                self.progress = Float(self.timerValue) / Float(self.totalTimeForCurrentSelection)
                
                if self.isFocusMode {
                    self.focusTimeAccumulated += 1 // Accumulate focus time
                }
            } else {
                // Timer reached zero
                self.timer.invalidate()
                
                if self.isFocusMode {
                    // Focus period has ended
                    self.updateFocusTimeAndCoins()
                    
                    // Switch to break mode
                    self.isFocusMode = false
                    self.timerValue = self.totalTimeForCurrentSelection
                    self.state = .active // Start break timer automatically
                } else {
                    // Break period has ended
                    // Reset to initial state
                    self.state = .cancelled
                }
            }
        }
    }
    
    /// Updates the focus minutes counter and coins earned after a focus session is completed
    private func updateFocusTimeAndCoins() {
        let minutesFocused = focusTimeAccumulated / 60
        focusMinutesCounter += minutesFocused
        focusTimeAccumulated = 0
        
        addCoinsIfEligible()
    }
    
    /// Adds coins based on the focus minutes counter.
    private func addCoinsIfEligible() {
        while focusMinutesCounter >= 10 {
            coinsEarned += 1
            focusMinutesCounter -= 10
        }
    }
}
