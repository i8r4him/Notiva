//
//  DurationInputView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.10.24.
//

import SwiftUI

struct TimerDuration: View {
    @ObservedObject var model: FocusViewModel
    
    @FocusState private var isFocusEditing: Bool
    @FocusState private var isBreakEditing: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // Hide keyboard and exit editing mode when tapping outside
                        isFocusEditing = false
                        isBreakEditing = false
                        hideKeyboard()
                    }
                
                VStack(spacing: 50) {
                    VStack {
                        HStack(alignment: .center, spacing: 30) {
                            
                            VStack(alignment: .center, spacing: 20) {
                                Text("Focus Duration")
                                    .font(.callout)
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.accentColor.opacity(0.3), lineWidth: 4)
                                    .frame(width: 140, height: 100)
                                    .overlay(
                                        // Use TextField with focus management and validation
                                        TextField("0", value: $model.focusDuration, formatter: NumberFormatter())
                                            .font(.system(size: 75, weight: .bold, design: .rounded))
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.numberPad)
                                            .focused($isFocusEditing)
                                            .onChange(of: model.focusDuration) {
                                                // Ensure the value is within the valid range of 1 to 60
                                                if model.focusDuration < 1 {
                                                    model.focusDuration = 1
                                                } else if model.focusDuration > 60 {
                                                    model.focusDuration = 60
                                                }
                                            }
                                            .onTapGesture {
                                                isFocusEditing = true // Activate keyboard on first tap
                                            }
                                    )
                                
                                HStack(spacing: 20) {
                                    Button(action: {
                                        if model.focusDuration > 1 {
                                            model.focusDuration -= 1
                                        } else {
                                            model.focusDuration = 60
                                        }
                                        triggerHapticFeedback()
                                    }) {
                                        Image(systemName: "arrow.down.circle")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.accentColor.opacity(0.3))
                                    }
                                    
                                    Button(action: {
                                        model.focusDuration = (model.focusDuration % 60) + 1
                                        triggerHapticFeedback()
                                    }) {
                                        Image(systemName: "arrow.up.circle")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.accentColor)
                                    }
                                }
                            }
                            
                            VStack(alignment: .center, spacing: 20) {
                                Text("Break Duration")
                                    .font(.callout)
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.accentColor.opacity(0.3), lineWidth: 4)
                                    .frame(width: 140, height: 100)
                                    .overlay(
                                        // Use TextField with focus management and validation
                                        TextField("0", value: $model.breakDuration, formatter: NumberFormatter())
                                            .font(.system(size: 75, weight: .bold, design: .rounded))
                                            .foregroundStyle(Color.gray)
                                            .multilineTextAlignment(.center)
                                            .keyboardType(.numberPad)
                                            .focused($isBreakEditing)
                                            .onChange(of: model.breakDuration) {
                                                // Ensure the value is within the valid range of 1 to 60
                                                if model.breakDuration < 0 {
                                                    model.breakDuration = 0
                                                } else if model.breakDuration > 60 {
                                                    model.breakDuration = 60
                                                }
                                            }
                                            .onTapGesture {
                                                isBreakEditing = true // Activate keyboard on first tap
                                            }
                                    )
                                
                                HStack(spacing: 20) {
                                    Button(action: {
                                        if model.breakDuration > 0 {
                                            model.breakDuration -= 1
                                        } else {
                                            model.breakDuration = 60
                                        }
                                        triggerHapticFeedback()
                                    }) {
                                        Image(systemName: "arrow.down.circle")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.accentColor.opacity(0.3))
                                    }
                                    
                                    Button(action: {
                                        model.breakDuration = (model.breakDuration + 1) % 61
                                        triggerHapticFeedback()
                                    }) {
                                        Image(systemName: "arrow.up.circle")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(.accentColor)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    Button(action: {
                        triggerHapticFeedback()
                        dismiss() // Dismiss the sheet view
                    }) {
                        Text("Set")
                    }
                    .buttonStyle(AllButtonsStyle())
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Set Focus and Break Duration")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Helper function to trigger haptic feedback
    private func triggerHapticFeedback() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
}

// Helper function to hide the keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    TimerDuration(model: FocusViewModel())
}
