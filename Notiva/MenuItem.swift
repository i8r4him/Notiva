
//  MenuItem.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.10.24.
//

import SwiftUI

enum MenuItem: Hashable, Identifiable {
    case home
    case notes
    case calendar
    case market
    case ai
    case focus
    case charts
    case todo
    case savedCourses
    case store
    

    var id: Self { self }

    var title: String {
        switch self {
        case .notes:
            return "Notes"
        case .home:
            return "Home"
        case .calendar:
            return "Calendar"
        case .market:
            return "Market"
        case .ai:
            return "Study with AI"
        case .focus:
            return "Focus"
        case .charts:
            return "Progress"
        case .todo:
            return "Todo"
        case .savedCourses:
            return "Saved Courses"
        case .store:
            return "Notiva Store"
            
        }
    }

    var systemImage: String {
        switch self {
        case .notes:
            return "book.pages"
        case .home:
            return "house"
        case .calendar:
            return "calendar"
        case .market:
            return "cart.badge.plus"
        case .ai:
            return "wand.and.sparkles.inverse"
        case .focus:
            return "timer"
        case .charts:
            return "flame"
        case .todo:
            return "list.clipboard"
        case .savedCourses:
            return "arrow.down.circle"
        case .store:
            return "storefront"
        }
    }
}

