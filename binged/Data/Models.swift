//
//  Models.swift
//  binged
//
//  Created by apprenant85 on 05/03/2026.
//

import SwiftUI
import Observation


// MARK: - Function to make dates 01/01/1970
extension Date {
    func formatDDMMYYYY() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}

// MARK: - Gestion des Images Airtable Attachment
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


// MARK: - enum GenreType
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
        case .crime: return "person.badge.shield.checkmark.fill"
        case .fantasy: return "wand.and.stars"
        case .action: return "figure.run"
        case .thriller: return "eye.trianglebadge.exclamationmark"
        case .horror: return "bolt.fill"
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
    let icon: [Attachment]?
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


// MARK: - CastMember (Actor)
struct CastMember: Codable, Identifiable {
    var id = UUID()
    
    let name: String
    let imageName: [Attachment?]
    var cityOfBirth: String?
    var bio: String?
    var dateOfBirthString: String?
    
    
    /// AIRTABLE
    var actorSerieIDs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "actorName"
        case imageName = "actorImage"
        case cityOfBirth = "actorCityOfBirth"
        case bio = "actorBio"
        case dateOfBirthString = "actorDateOfBirth"
        case actorSerieIDs = "ActorSerie"
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


// MARK: - ActorSerie (Roles)
struct ActorSerie: Codable, Identifiable {
    var id = UUID()
    var roleName: String
    
    var actor: CastMember?
    
    var actorIDs: [String]?
    var serieIDs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case roleName
        case actorIDs = "actor"
        case serieIDs = "Serie"
    }
}

struct ActorSeriesResponse: Codable { let records: [ActorSerieRecord] }

struct ActorSerieRecord: Codable {
    let id: String
    let fields: ActorSerie
}


// MARK: - Serie
@Observable
class Serie: Codable, Identifiable {
    var id = UUID()
    let name: String
    let desc: String
    let type: Kind
    let cover: [Attachment]?
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
    
    init(name: String, desc: String, type: Kind, cover: [Attachment]?, year: Int, decennie: String, genre: GenreType, actors: [ActorSerie] = [], platform: [Platform] = [], reviews: [ReviewItem] = [], nbSaisons: Int, nbEpisodes: Int, inProgress: Bool? = nil, trailerURL: String? = nil) {
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.type = try container.decode(Kind.self, forKey: .type)
        self.cover = try container.decodeIfPresent([Attachment].self, forKey: .cover)
        self.year = try container.decode(Int.self, forKey: .year)
        self.decennie = try container.decode(String.self, forKey: .decennie)
        self.genre = try container.decode(GenreType.self, forKey: .genre)
        self.nbSaisons = try container.decode(Int.self, forKey: .nbSaisons)
        self.nbEpisodes = try container.decode(Int.self, forKey: .nbEpisodes)
        self.inProgress = try container.decodeIfPresent(Bool.self, forKey: .inProgress)
        self.trailerURL = try container.decodeIfPresent(String.self, forKey: .trailerURL)
        self.actorIDs = try container.decodeIfPresent([String].self, forKey: .actorIDs)
        self.platformIDs = try container.decodeIfPresent([String].self, forKey: .platformIDs)
        self.reviewIDs = try container.decodeIfPresent([String].self, forKey: .reviewIDs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(type, forKey: .type)
        try container.encode(cover, forKey: .cover)
        try container.encode(year, forKey: .year)
        try container.encode(decennie, forKey: .decennie)
        try container.encode(genre, forKey: .genre)
        try container.encode(nbSaisons, forKey: .nbSaisons)
        try container.encode(nbEpisodes, forKey: .nbEpisodes)
        try container.encode(inProgress, forKey: .inProgress)
        try container.encode(trailerURL, forKey: .trailerURL)
        try container.encode(actorIDs, forKey: .actorIDs)
        try container.encode(platformIDs, forKey: .platformIDs)
        try container.encode(reviewIDs, forKey: .reviewIDs)
    }
}

struct SeriesResponse: Codable {
    let records: [SerieRecord]
}

struct SerieRecord: Codable {
    let id: String
    let fields: Serie
}


// MARK: - Modèle Playlist
@Observable
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.serieIDs = try container.decodeIfPresent([String].self, forKey: .serieIDs)
        self.creatorIDs = try container.decodeIfPresent([String].self, forKey: .creatorIDs)
        self.abonneeIDs = try container.decodeIfPresent([String].self, forKey: .abonneeIDs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(serieIDs, forKey: .serieIDs)
        try container.encode(creatorIDs, forKey: .creatorIDs)
        try container.encode(abonneeIDs, forKey: .abonneeIDs)
    }
}

struct PlaylistsResponse: Codable { let records: [PlaylistRecord] }

struct PlaylistRecord: Codable {
    let id: String
    let fields: Playlist
}


// MARK: - Classe USER
@Observable
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.email = try container.decode(String.self, forKey: .email)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.age = try container.decodeIfPresent(Int.self, forKey: .age)
        self.userBio = try container.decodeIfPresent(String.self, forKey: .userBio)
        self.picture = try container.decodeIfPresent([Attachment].self, forKey: .picture)
        self.favoriteGenreStrings = try container.decodeIfPresent([String].self, forKey: .favoriteGenreStrings)
        self.favoriteSerieIDs = try container.decodeIfPresent([String].self, forKey: .favoriteSerieIDs)
        self.favoriteActorIDs = try container.decodeIfPresent([String].self, forKey: .favoriteActorIDs)
        self.playlistIDs = try container.decodeIfPresent([String].self, forKey: .playlistIDs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(email, forKey: .email)
        try container.encode(userName, forKey: .userName)
        try container.encode(age, forKey: .age)
        try container.encode(userBio, forKey: .userBio)
        try container.encode(picture, forKey: .picture)
        try container.encode(favoriteGenreStrings, forKey: .favoriteGenreStrings)
        try container.encode(favoriteSerieIDs, forKey: .favoriteSerieIDs)
        try container.encode(favoriteActorIDs, forKey: .favoriteActorIDs)
        try container.encode(playlistIDs, forKey: .playlistIDs)
    }
}

struct UsersResponse: Codable { let records: [UserRecord] }
struct UserRecord: Codable {
    let id: String
    let fields: User
}



// MARK: - ReviewItem
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
