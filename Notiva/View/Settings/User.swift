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
    
    init(
        name: String = "",
        level: Int = 0,
        awards: Int = 0,
        streak: Int = 0
    ) {
        self.name = name
        self.level = level
        self.awards = awards
        self.streak = streak
    }
}
