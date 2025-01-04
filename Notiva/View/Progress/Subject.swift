//
//  Subject.swift
//  Notiva
//
//  Created by Ibrahim Abdullah on 02.01.25.
//

import Foundation
import SwiftData
import SwiftUI

/// Represents a subject in the academic curriculum
@Model
class Subject: Identifiable {
    var id = UUID()
    var name: String
    var credit: Int
    var color: String  // Stores hex color string
    var type: Type
    @Relationship(deleteRule: .nullify, inverse: \Major.subjects)
    var major: Major?  // Reference to the major this subject belongs to
    
    init(
        id: UUID = UUID(),
        name: String = "",
        credit: Int = 0,
        color: String = "#007AFF",  // Default iOS blue color in hex
        type: Type = .pflicht,
        major: Major? = nil
    ) {
        self.id = id
        self.name = name
        self.credit = credit
        self.color = color
        self.type = type
        self.major = major
    }
    
    /// Converts the stored hex color string to a SwiftUI Color
    var colorValue: Color {
        Color(hex: color) ?? .blue  // Fallback to blue if hex string is invalid
    }
}

/// Represents different types of academic subjects
enum Type: String, Codable, CaseIterable {
    case pflicht = "Pflicht"
    case wahlpflicht = "Wahlpflicht"
    case praktikum = "Praktikum"
    case other = "Other"
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
    
    /// Converts Color to hex string
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let hex = String(format: "#%02lX%02lX%02lX",
                        lroundf(r * 255),
                        lroundf(g * 255),
                        lroundf(b * 255))
        return hex
    }
}
