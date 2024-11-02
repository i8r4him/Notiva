//
//  ButtonStyle.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 06.10.24.
//

import SwiftUI

/// Define a custom button style named `AllButtonsStyle` that conforms to the `ButtonStyle` protocol.
struct AllButtonsStyle: ButtonStyle {
    
    /// The `makeBody` function is required by the `ButtonStyle` protocol.
    /// It defines how the button should be styled and presented.
    /// - Parameter configuration: Contains properties and states of the button, like whether it's pressed.
    /// - Returns: A view that represents the styled button.
    func makeBody(configuration: Configuration) -> some View {
        // Start with the button's label (text or image content) provided when creating the button.
        configuration.label
            .frame(width: 100, height: 30)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    VStack {
        Button("Pause") {}
        .buttonStyle(AllButtonsStyle())
    }
}

