//
//  DestinationHelper.swift
//  Productivity Pro
//
//  Created by Ibrahim Abdullah on 01.11.24.
//

import SwiftUI
import SwiftData

struct DestinationHelper {
    // Updated method to accept contentObjects as a parameter
    static func destinationView(for item: MenuItem, contentObjects: [ContentObject]) -> some View {
        switch item {
        case .notes:
            return AnyView(FileSystemView(contentObjects: contentObjects))
        case .home:
            return AnyView(HomeView())
        case .calendar:
            return AnyView(CalendarView())
        case .market:
            return AnyView(MarketView())
        case .ai:
            return AnyView(AIView())
        case .focus:
            return AnyView(FocusView())
        case .charts:
            return AnyView(ChartsView())
        case .todo:
            return AnyView(TodoView())
        case .savedCourses:
            return AnyView(SavedCoursesView())
        case .store:
            return AnyView(StoreView())
        }
    }
}


