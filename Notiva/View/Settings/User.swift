//
//  SingleUserManager.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 03.01.25.
//

import SwiftData
import Foundation
import SwiftUI

@Model
class User {
    var name: String
    var level: Int
    var awards: Int
    var streak: Int
    var isPremium: Bool
    var imageData: Data?
    var lastLoginDate: Date
    
    @Relationship(deleteRule: .nullify)
    var major: Major?
    
    init(
        name: String = "New User",
        level: Int = 1,
        awards: Int = 0,
        streak: Int = 0,
        isPremium: Bool = false,
        imageData: Data? = nil,
        lastLoginDate: Date = Date(),
        major: Major? = nil
    ) {
        self.name = name
        self.level = level
        self.awards = awards
        self.streak = streak
        self.isPremium = isPremium
        self.imageData = imageData
        self.lastLoginDate = lastLoginDate
        self.major = major
    }
}
