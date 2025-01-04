//
//  Major.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 02.01.25.
//

import Foundation
import SwiftData

/// Represents an academic major or degree program
@Model
class Major: Identifiable {
    // Your properties
    var id = UUID()
    var name: String
    var credit: Int
    
    // Relationship to subjects with cascade delete rule
    @Relationship(deleteRule: .cascade)
    var subjects: [Subject] = []
    
    @Relationship(deleteRule: .nullify, inverse: \User.major)
    var user: User?
    
    init(
        id: UUID = UUID(),
        name: String = "",
        credit: Int = 0,
        user: User? = nil
    ) {
        self.id = id
        self.name = name
        self.credit = credit
        self.user = user
    }
    
    /// Calculates total credits from all subjects
    var earnedCredits: Int {
        subjects.reduce(0) { $0 + $1.credit }
    }
    
    /// Calculates progress as a percentage
    var progress: Double {
        credit > 0 ? Double(earnedCredits) / Double(credit) : 0
    }
}
