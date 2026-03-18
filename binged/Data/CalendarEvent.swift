//
//  CalendarEvent.swift
//  binged
//
//  Created by apprenant85 on 16/03/2026.
//


import Foundation

struct CalendarEvent: Codable, Identifiable {
    var id = UUID()
    let episodeName: String
    let date: Date
    
    var serieID: [String]?
    var serie: Serie?
    
    enum CodingKeys: String, CodingKey {
        case episodeName = "EpisodeName"
        case date = "Date"
        case serieID = "Serie"
    }
}

struct CalendarResponse: Codable { let records: [CalendarRecord] }
struct CalendarRecord: Codable {
    let id: String
    let fields: CalendarEvent
}
