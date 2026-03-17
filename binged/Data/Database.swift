//
//  Database.swift
//  binged
//

import SwiftUI

let standard = Kind.standard
let mini = Kind.mini
let anthology = Kind.anthology

// MARK: - Fonction Utilitaire pour les Dates
func createDate(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
}

extension Date {
    func formatTo(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: self)
    }
}
