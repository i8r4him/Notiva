//
//  SearchView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 31.12.24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "mail.and.text.magnifyingglass", description: Text("Not yet implemented"))
                .navigationTitle("Search")
        }
        .environment(\.symbolRenderingMode, .hierarchical)
    }
}

#Preview {
    SearchView()
}
