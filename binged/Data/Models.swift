//
//  Models.swift
//  binged
//
//  Created by apprenant85 on 05/03/2026.
//

import SwiftUI
import Observation


/// Function to make dates 01/01/1970
extension Date {
    func formatDDMMYYYY() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}

// MARK: - Gestion des Images Airtable
struct Attachment: Codable {
    let id: String
    let url: URL
    let thumbnails: Thumbnails?
}

struct Thumbnails: Codable {
    let small: ThumbnailVariant?
    let large: ThumbnailVariant?
    let full: ThumbnailVariant?
}

struct ThumbnailVariant: Codable {
    let url: URL
}


/// enum GenreType
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
    
    var icon: String {
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
/// enum Kind = Type
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



// MARK: - Netflix, Prime Video, Paramount, Crunchyroll, ADN
struct Platform: Codable, Identifiable {
    var id = UUID()
    
    let name: String
    let icon: String
    let baseURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name, icon, baseURL
    }
}

struct PlatformsResponse: Codable { let records: [PlatformRecord] }

struct PlatformRecord: Codable {
    let id: String
    let fields: Platform
}

struct CastMember: Codable, Identifiable {
    var id = UUID()
    
    let name: String
    let imageName: String?
    var cityOfBirth: String?
    var bio: String?
    var dateOfBirthString: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "actorName"
        case imageName = "actorImage"
        case cityOfBirth = "actorCityOfBirth"
        case bio = "actorBio"
        case dateOfBirthString = "actorDateOfBirth"
    }
    
    var dateOfBirth: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateOfBirthString ?? "") ?? Date()
    }
    
    var age: Int {
        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
    }
}


struct CastMemberResponse: Codable { let records: [CastMemberRecord] }

struct CastMemberRecord: Codable {
    let id: String
    let fields: CastMember
}


struct ActorSerie: Codable, Identifiable {
    var id = UUID()
    var roleName: String
    
    var actor: CastMember?
    
    var actorIDs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case roleName
        case actorIDs = "actor"
    }
}

struct ActorSeriesResponse: Codable { let records: [ActorSerieRecord] }

struct ActorSerieRecord: Codable {
    let id: String
    let fields: ActorSerie
}


/// USER = Ses favorites kinds seront un tableau de Kind




class Serie: Codable, Identifiable {
    var id = UUID()
    let name: String
    let desc: String
    let type: Kind
    let cover: String?
    let year: Int
    let decennie: String
    let genre: GenreType
    var nbSaisons: Int
    var nbEpisodes: Int
    var inProgress: Bool?
    let trailerURL: String?
    
    var actorIDs: [String]?
    var platformIDs: [String]?
    var reviewIDs: [String]?
    
    var actors: [ActorSerie] = []
    var platform: [Platform] = []
    var reviews: [ReviewItem] = []
    
    enum CodingKeys: String, CodingKey {
        case name, desc, type, cover, year, decennie, genre, nbSaisons, nbEpisodes, inProgress, trailerURL
        case actorIDs = "actors"
        case platformIDs = "platform"
        case reviewIDs = "Reviews"
    }
    
    init(name: String, desc: String, type: Kind, cover: String?, year: Int, decennie: String, genre: GenreType, actors: [ActorSerie] = [], platform: [Platform] = [], reviews: [ReviewItem] = [], nbSaisons: Int, nbEpisodes: Int, inProgress: Bool? = nil, trailerURL: String? = nil) {
        self.name = name
        self.desc = desc
        self.type = type
        self.cover = cover
        self.year = year
        self.decennie = decennie
        self.genre = genre
        self.nbSaisons = nbSaisons
        self.nbEpisodes = nbEpisodes
        self.inProgress = inProgress
        self.actors = actors
        self.platform = platform
        self.reviews = reviews
        self.trailerURL = trailerURL
    }
}

struct SeriesResponse: Codable {
    let records: [SerieRecord]
}

struct SerieRecord: Codable {
    let id: String?
    let fields: Serie
}


// MARK: - Modèle Playlist
class Playlist: Codable, Identifiable {
    var id = UUID()
    
    var name: String
    
    var serieIDs: [String]?
    var creatorIDs: [String]?
    var abonneeIDs: [String]?
    // --- LES VRAIS OBJETS ---
    var series: [Serie]? = []
    var creator: User?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case serieIDs = "serie"
        case creatorIDs = "creator"
        case abonneeIDs = "abonnee"
    }
    
    init(name: String, serieIDs: [String] = [], creatorIDs: [String] = [], abonneeIDs: [String] = [], series: [Serie]? = [], creator: User? = nil) {
        self.name = name
        
        self.series = series
        self.creator = creator
        self.abonneeIDs = abonneeIDs
        
        self.serieIDs = serieIDs
        self.creatorIDs = creatorIDs
    }
}

struct PlaylistsResponse: Codable { let records: [PlaylistRecord] }
struct PlaylistRecord: Codable {
    let id: String
    let fields: Playlist
}



class User: Codable, Identifiable {
    var id = UUID()
    
    var lastName: String?
    var firstName: String?
    var email: String
    var userName: String
    var age: Int?
    var userBio: String?
    
    var picture: [Attachment]?
    
    var favoriteGenreStrings: [String]?
    
    /// AIRTABLE
    var favoriteSerieIDs: [String]?
    var favoriteActorIDs: [String]?
    var playlistIDs: [String]?
    var reviewIDs: [String]?
    
    
    /// OBJETS RÉÉLS
    var favoriteSeries: [Serie?] = []
    var favoriteActors: [CastMember?] = []
    var playlists: [Playlist?] = []
    
    var favoriteGenres: [GenreType] {
        return favoriteGenreStrings?.compactMap { GenreType(rawValue: $0) } ?? []
    }
    
    var favoriteActorsSafe: [CastMember] {
        return favoriteActors.compactMap { $0 }
    }
    
    var favoriteSeriesSafe: [Serie] {
        return favoriteSeries.compactMap { $0 }
    }
    
    enum CodingKeys: String, CodingKey {
        case lastName, firstName, email, userName, age, userBio, picture
        case favoriteGenreStrings = "favoriteGenre"
        case favoriteSerieIDs = "favoriteSerie"
        case favoriteActorIDs = "favoriteActor"
        case playlistIDs = "myPlaylist"
    }
    
    init(lastName: String? = nil, firstName: String? = nil, email: String, userName: String, age: Int? = nil, userBio: String? = nil, picture: [Attachment]? = nil, favoriteGenreStrings: [String]? = nil, playlistIDs: [String] = [], favoriteSeries: [Serie?] = [], favoriteActors: [CastMember?] = [], playlists: [Playlist?] = []) {
        self.lastName = lastName
        self.firstName = firstName
        self.email = email
        self.userName = userName
        self.age = age
        self.userBio = userBio
        self.picture = picture
        
        self.favoriteGenreStrings = favoriteGenreStrings
        self.playlistIDs = playlistIDs
        self.favoriteSeries = favoriteSeries
        self.favoriteActors = favoriteActors
        self.playlists = playlists
        
        self.favoriteSerieIDs = nil
        self.favoriteActorIDs = nil
    }
}

struct UsersResponse: Codable { let records: [UserRecord] }
struct UserRecord: Codable {
    let id: String
    let fields: User
}


struct ReviewItem: Codable, Identifiable {
    var id = UUID()
    let user: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case user
        case text = "content"
    }
}

struct ReviewRecord: Codable {
    let id: String
    let fields: ReviewItem
}

struct ReviewResponse: Codable {
    let records: [ReviewRecord]
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isMe: Bool
}
