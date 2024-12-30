//
//  HomeView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "house", description: Text("Not yet implemented"))
                .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
