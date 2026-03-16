//
//  User.swift
//  binged
//
//  Created by Apprenant 92 on 04/03/2026.
//

import Foundation

let allGenres: [Genre] = Genre.allCases.map { $0 }


struct UserResponse: Codable {
    let records: UserResults
}

struct UserResults: Codable {
    let fields: User
}

struct User: Identifiable, Codable, Hashable {
    var id = UUID()
    var lastName: String?
    var firstName: String?
    var username: String
    var email: String = ""
//    var picture: String?
    var age: Int
    var userBio: String?
    var favoriteGenre: [Genre] = []
    var favoriteSerie: [String] = []
    var favoriteActor: [String] = []
//    var posts: [Post?] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName
        case firstName
        case username = "userName"
        case email
//        case picture
        case age
        case userBio
        case favoriteGenre
        case favoriteSerie
        case favoriteActor
    }
    
    init(id: UUID = UUID(),
         lastName: String? = nil,
         firstName: String? = nil,
         username: String,
         email: String = "",
//         picture: String? = nil,
         age: Int,
         userBio: String? = nil,
         favoriteGenre: [Genre] = [],
         favoriteSerie: [String] = [],
         favoriteActor: [String] = []) {
        self.id = id
        self.lastName = lastName
        self.firstName = firstName
        self.username = username
        self.email = email
//        self.picture = picture
        self.age = age
        self.userBio = userBio
        self.favoriteGenre = favoriteGenre
        self.favoriteSerie = favoriteSerie
        self.favoriteActor = favoriteActor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
//        picture = try container.decodeIfPresent(String.self, forKey: .picture)
        age = try container.decode(Int.self, forKey: .age)
        userBio = try container.decodeIfPresent(String.self, forKey: .userBio)
        favoriteGenre = try container.decodeIfPresent([Genre].self, forKey: .favoriteGenre) ?? []
        favoriteSerie = try container.decodeIfPresent([String].self, forKey: .favoriteSerie) ?? []
        favoriteActor = try container.decodeIfPresent([String].self, forKey: .favoriteActor) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
//        try container.encodeIfPresent(picture, forKey: .picture)
        try container.encode(age, forKey: .age)
        try container.encodeIfPresent(userBio, forKey: .userBio)
        try container.encode(favoriteGenre, forKey: .favoriteGenre)
        try container.encode(favoriteSerie, forKey: .favoriteSerie)
        try container.encode(favoriteActor, forKey: .favoriteActor)
    }
    static func == (lhs: User, rhs: User) -> Bool {
           lhs.id == rhs.id
       }

       func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }
}

var magalie = User(
    lastName: "Piquet",
    firstName: "Magalie",
    username: "Piquima",
    email: "Magalie@lecercle.mali",
//    picture: "magalie",
    age: 70,
    userBio: "j'adore les séries des années 1990",
    favoriteGenre: [.action, .animation],
    favoriteSerie: [],
    favoriteActor: ["recijwp1caAjQx6ah", "recD3dqgu5ofUgJyD"]
 //   posts: postsMagalie
)
