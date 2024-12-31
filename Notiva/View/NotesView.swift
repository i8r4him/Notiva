//
//  NotesView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 31.12.24.
//

import SwiftUI

struct NotesView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "book.pages", description: Text("Not yet implemented"))
                .navigationTitle("Notes")
        }
    }
}

#Preview {
    NotesView()
}
