//
//  Models.swift
//  binged
//
//  Created by apprenant85 on 05/03/2026.
//

import SwiftUI


@Observable
class Genre {
    var id = UUID()
    let type: GenreType
    var isFavorite: Bool?

    var icon: String {
        type.iconName
    }

    var name: String {
        type.rawValue
    }

    init(id: UUID = UUID(), type: GenreType, isFavorite: Bool? = nil) {
        self.id = id
        self.type = type
        self.isFavorite = isFavorite
    }

}

enum GenreType: String, CaseIterable {

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

@Observable
class YearSerie {
    var id = UUID()
    let value: String
    var isFavorite: Bool?
    
    init(id: UUID = UUID(), value: String, isFavorite: Bool? = nil) {
        self.id = id
        self.value = value
        self.isFavorite = isFavorite
    }
}



enum Kind: String, CaseIterable {
    case standard = "Série"
    case mini = "Mini-série"
    case anthology = "Anthologie"
    case docuseries = "Série documentaire"
    case daily = "Quotidienne"

    var iconName: String {
        switch self {
        case .standard: return "tv"
        case .mini: return "square.stack.3d.up.fill"
        case .anthology: return "circle.grid.2x2.fill"
        case .docuseries: return "video.badge.waveform.fill"
        case .daily: return "calendar.badge.clock"
            
        }
    }
}

@Observable
class SerieType: Identifiable {
    var id = UUID()
    let kind: Kind
    var isFavorite: Bool?

    var name: String { kind.rawValue }
    var icon: String { kind.iconName }

    init(kind: Kind, isFavorite: Bool? = nil) {
        self.kind = kind
        self.isFavorite = isFavorite
    }
}



struct Platform {  // Netflix, Prime Video, Paramount, Crunchyroll, ADN
    let name: String
    let baseURL: String
    let icon: String
}

struct ActorSerie {
    /// A FAIRE
}


@Observable
class Serie: Identifiable {
    var id = UUID()
    let name: String
    let desc: String
    let type: SerieType
    let cover: String?
    let year: Int
    let decennie: YearSerie
    let genre: Genre
    let actors: [ActorSerie?]
    var platform: [Platform]
    var nbSaisons: Int
    var nbEpisodes: Int
    var inProgress: Bool?
    
    init(id: UUID = UUID(), name: String, desc: String, type: SerieType, cover: String?, year: Int, decennie: YearSerie, genre: Genre, actors: [ActorSerie?], platform: [Platform], nbSaisons: Int, nbEpisodes: Int, inProgress: Bool? = nil) {
        self.id = id
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

struct Actor: Identifiable
{
    var id = UUID()
    var actorFirstName: String
    var actorLastName: String
    var actorImage: String
    var actorDateOfBirth: Date
    var actorCityOfBirth: String
    var actorBio: String
//    var actorFilmographie: String
    var actorAge: Int {
           Calendar.current.dateComponents([.year], from: actorDateOfBirth, to: Date()).year!
    }
}

struct User: Identifiable, Hashable//, Equatable
{
    var id = UUID()
    var lastName: String?
    var firstName: String?
    var Username: String
    var email: String = ""
    var picture: String?
    var age: Int
    var userBio: String?
//  var favoriteGenre: [favoriteGenre] = []
//    var favoriteSeries: [SeriesName?] = []
//    var favoriteActors: [ActorName?] = []
//    var posts: [Post?] = []
}
