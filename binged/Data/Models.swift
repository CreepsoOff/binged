//
//  Models.swift
//  binged
//
//  Created by apprenant85 on 05/03/2026.
//

import SwiftUI
import Observation


//class Genre: Codable, Identifiable {
//    var id = UUID()
//    let type: GenreType
//    var isFavorite: Bool?
//
//    var icon: String {
//        type.iconName
//    }
//
//    var name: String {
//        type.rawValue
//    }
//
//    init(id: UUID = UUID(), type: GenreType, isFavorite: Bool? = nil) {
//        self.id = id
//        self.type = type
//        self.isFavorite = isFavorite
//    }
//    
//
//}

enum GenreType: String, CaseIterable, Codable {

    case sf = "Sciences Fiction"
    case drama = "Drame"
    case comedy = "Comédie"
    case crime = "Crime"
    case fantasy = "Fantastique"
    case action = "Action & Aventure"
    case thriller = "Thriller"
    case horror = "Horreur"
    case romance = "Romance"
    case documentary = "Documentaire"
    case medical = "Médical"
    case legal = "Judiciaire"
    case animation = "Animation"
    case mystery = "Mystère"
    case history = "Historique"
    case war = "Guerre"
    case western = "Western"
    case anime = "Anime"

    var iconName: String {
        switch self {
        case .sf: return "atom"
        case .drama: return "theatermasks.fill"
        case .comedy: return "face.smiling.fill"
        case .crime: return "person.badge.shield.checkered.fill"
        case .fantasy: return "wand.and.stars"
        case .action: return "figure.run"
        case .thriller: return "eye.trianglebadge.exclamationmark"
        case .horror: return "ghost.fill"
        case .romance: return "heart.fill"
        case .documentary: return "camera.aperture"
        case .medical: return "cross.case.fill"
        case .legal: return "gavel.fill"
        case .animation: return "paintpalette.fill"
        case .mystery: return "magnifyingglass"
        case .history: return "columns.2"
        case .war: return "shield.fill"
        case .western: return "tent.fill"
        case .anime: return "mountain.2.fill"
        }
    }
}

//@Observable
//class YearSerie {
//    var id = UUID()
//    let value: String
//    var isFavorite: Bool?
//    
//    init(id: UUID = UUID(), value: String, isFavorite: Bool? = nil) {
//        self.id = id
//        self.value = value
//        self.isFavorite = isFavorite
//    }
//}



enum Kind: String, CaseIterable, Codable {
    case standard = "Série"
    case mini = "Mini-série"
    case anthology = "Anthologie"
    case docuseries = "Série documentaire"
    case daily = "Quotidienne"

    var icon: String {
        switch self {
        case .standard: return "tv"
        case .mini: return "square.stack.3d.up.fill"
        case .anthology: return "circle.grid.2x2.fill"
        case .docuseries: return "video.badge.waveform.fill"
        case .daily: return "calendar.badge.clock"
            
        }
    }
}



struct Platform: Codable {  // Netflix, Prime Video, Paramount, Crunchyroll, ADN
    let name: String
    let baseURL: String
    let icon: String
}

struct ActorSerie: Codable {
    /// A FAIRE
}



/// USER = Ses favorites kinds seront un tableau de Kind


class Serie: Codable {
    let name: String
    let desc: String
    let type: Kind
    let cover: String?
    let year: Int
    let decennie: String
    let genre: GenreType
    let actors: [ActorSerie?]
    var platform: [Platform?]
    var nbSaisons: Int
    var nbEpisodes: Int
    var inProgress: Bool?
    
  
    
    init( name: String, desc: String, type: Kind, cover: String?, year: Int, decennie: String, genre: GenreType, actors: [ActorSerie?], platform: [Platform?], nbSaisons: Int, nbEpisodes: Int, inProgress: Bool? = nil) {
        self.name = name
        self.desc = desc
        self.type = type
        self.cover = cover
        self.year = year
        self.decennie = decennie
        self.genre = genre
        self.actors = actors
        self.platform = platform
        self.nbSaisons = nbSaisons
        self.nbEpisodes = nbEpisodes
        self.inProgress = inProgress
    }
    
    
}

//@Observable
//class Playlist: Identifiable {
//    var id = UUID()
//    
//    
//}



struct SeriesResponse: Codable {
    let records: [SerieRecord]
}

struct SerieRecord: Codable {
    let fields: Serie
}


