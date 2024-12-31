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
            VStack(spacing: 20) {
                Image(systemName: "gift.fill")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                
                // Tip Options
                ForEach(viewModel.tipOptions) { option in
                    Button(action: {
                        viewModel.handleTipSelection(amount: option.amount) // TODO: Connect to tip logic
                        dismiss()
                    }) {
                        VStack {
                            Text(option.title)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(viewModel.currencyFormatter.string(from: NSNumber(value: option.amount)) ?? "")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(option.color)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationTitle("Support the Developer")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TipView()
}
