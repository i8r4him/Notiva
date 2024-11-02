//
//  StoreView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 20.10.24.
//

import SwiftUI

struct StoreView: View {
    var body: some View {
        
        NavigationStack {
            ContentUnavailableView("Nothing in the store yet.", systemImage: "cart", description: Text("Coming soon..."))
                .navigationTitle("Notiva Store")
        }
    }
}

#Preview {
    StoreView()
}
