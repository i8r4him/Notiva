//
//  CalendarView.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 30.12.24.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView("Coming Soon", systemImage: "calendar", description: Text("Not yet implemented"))
                .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView()
}
