//
//  ProgressView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct ProgressView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "chart.bar", description: Text("Not yet implemented"))
                .navigationTitle("Progress")
        }
    }
}

#Preview {
    ProgressView()
}
