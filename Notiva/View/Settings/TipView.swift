//
//  TipView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 31.12.24.
//

import SwiftUI

struct TipView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = TipViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    Image(systemName: "gift.fill")
                        .font(.largeTitle)
                        .foregroundColor(.accentColor)
                    
                    Text("Your support helps us continue improving the app!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Small and Little Tips Row
                        HStack(spacing: 12) {
                            // Little Tip Button
                            makeTipButton(for: viewModel.tipOptions[0])
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .layoutPriority(1)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
                            
                            // Small Tip Button
                            makeTipButton(for: viewModel.tipOptions[1])
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .layoutPriority(1)
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                        }
                        
                        // Larger Tips
                        ForEach(Array(viewModel.tipOptions.dropFirst(2))) { option in
                            makeTipButton(for: option)
                                .frame(maxWidth: .infinity, minHeight: 100)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Support the Developer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Helper function to create consistent tip buttons
    private func makeTipButton(for option: TipOption) -> some View {
        Button(action: {
            viewModel.handleTipSelection(amount: option.amount) // TODO: Connect to tip logic
            dismiss()
        }) {
            VStack(spacing: 8) {
                Text(option.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(viewModel.currencyFormatter.string(from: NSNumber(value: option.amount)) ?? "")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                option.color
                    .opacity(0.8) // Add opacity to the background
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(option.color.opacity(0.3), lineWidth: 2)
            )
            .cornerRadius(15)
            .shadow(radius: 4)
        }
    }
}

#Preview {
    TipView()
}
