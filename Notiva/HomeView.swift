//
//  HomeView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.10.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            HStack {
                ContentUnavailableView("Here is a overview of your Profile in Notiva", systemImage: "house", description: Text("Coming soon..."))
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "crown.fill")
                            .foregroundColor(.indigo)
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
