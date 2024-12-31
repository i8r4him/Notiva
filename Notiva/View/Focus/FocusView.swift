//
//  FocusView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct FocusView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "timer", description: Text("Not yet implemented"))
                .navigationTitle("Focus")
        }
    }
}

#Preview {
    FocusView()
}
