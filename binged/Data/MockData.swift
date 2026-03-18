import Foundation

enum MockData {
    
    // MARK: - 1. Fausse Image (Airtable Attachment)
    static let mockURL = URL(string: "https://movix.rodeo/avatars/mickey/mickey_avatar_1.png")!
    static let mockThumb = ThumbnailVariant(url: mockURL)
    static let mockThumbs = Thumbnails(small: mockThumb, large: mockThumb, full: mockThumb)
    static let mockAttachment = Attachment(id: "att123", url: mockURL, thumbnails: mockThumbs)
    
    static let mockURLcolette = URL(string: "https://movix.rodeo/avatars/mickey/mickey_avatar_1.png")!
    static let mockThumbColette = ThumbnailVariant(url: mockURLcolette)
    static let mockThumbsColette = Thumbnails(small: mockThumbColette, large: mockThumbColette, full: mockThumbColette)
    static let mockAttachmentColette = Attachment(id: "att456", url: mockURLcolette, thumbnails: mockThumbsColette)
    
    
    // MARK: - 2. Plateformes
    static let netflix = Platform(name: "Netflix", icon: "netflix_icon", baseURL: "https://netflix.com")
    
    // MARK: - 3. Acteurs (CastMember)
    static let bryanCranston = CastMember(
        name: "Bryan Cranston",
        imageName: "bryan_cranston",
        cityOfBirth: "Hollywood",
        bio: "Acteur de génie, inoubliable dans Malcolm et Breaking Bad.",
        dateOfBirthString: "1956-03-07"
    )
    
    static let aaronPaul = CastMember(
        name: "Aaron Paul",
        imageName: "aaron_paul",
        cityOfBirth: "Emmett",
        bio: "Yeah, Science, bitch!",
        dateOfBirthString: "1979-08-27"
    )
    
    static let cillianMurphy = CastMember(
        name: "Cillian Murphy",
        imageName: "cillian_murphy",
        cityOfBirth: "Douglas",
        bio: "Acteur irlandais charismatique, célèbre pour son rôle de Thomas Shelby.",
        dateOfBirthString: "1976-05-25"
    )
    
    static let benedictCumberbatch = CastMember(
        name: "Benedict Cumberbatch",
        imageName: "benedict_cumberbatch",
        cityOfBirth: "Londres",
        bio: "Acteur britannique mondialement connu pour son interprétation du détective Sherlock Holmes.",
        dateOfBirthString: "1976-07-19"
    )
    
    // MARK: - 4. Rôles (ActorSerie)
    static let roleWalter = ActorSerie(roleName: "Walter White", actor: bryanCranston)
    static let roleJesse = ActorSerie(roleName: "Jesse Pinkman", actor: aaronPaul)
    static let roleThomas = ActorSerie(roleName: "Thomas Shelby", actor: cillianMurphy)
    static let roleSherlock = ActorSerie(roleName: "Sherlock Holmes", actor: benedictCumberbatch)
    
    // MARK: - 5. Séries
    static let breakingBad = Serie(
        name: "Breaking Bad",
        desc: "Un professeur de chimie atteint d'un cancer s'associe à un ancien élève pour fabriquer et vendre de la méthamphétamine.",
        type: .standard,
        cover: "breaking_bad_cover",
        year: 2008,
        decennie: "2000s",
        genre: .crime,
        actors: [roleWalter, roleJesse],
        platform: [netflix],
        nbSaisons: 5,
        nbEpisodes: 62,
        inProgress: false
    )
    
    static let peakyBlinders = Serie(
        name: "Peaky Blinders",
        desc: "L'épopée d'une famille de gangsters de Birmingham à partir de 1919, menée par le redoutable Tommy Shelby.",
        type: .standard,
        cover: "peaky_cover",
        year: 2013,
        decennie: "2010s",
        genre: .crime,
        actors: [roleThomas],
        platform: [netflix],
        nbSaisons: 6,
        nbEpisodes: 36,
        inProgress: false
    )
    
    static let sherlock = Serie(
        name: "Sherlock",
        desc: "Une adaptation moderne des aventures du détective Sherlock Holmes et de son colocataire le Dr Watson.",
        type: .standard,
        cover: "sherlock_cover",
        year: 2010,
        decennie: "2010s",
        genre: .crime,
        actors: [roleSherlock],
        platform: [netflix],
        nbSaisons: 4,
        nbEpisodes: 13,
        inProgress: false
    )
    
    // MARK: - 6. Playlists
    static let playlistHiver = Playlist(
        name: "Soirée d'hiver",
        series: [breakingBad, peakyBlinders]
    )
    
    // MARK: - 7. Utilisateurs (User)
    static let magalie = User(
        lastName: "Piquet",
        firstName: "Magalie",
        email: "magalie@lecercle.mali",
        userName: "Piquima",
        age: 70,
        userBio: "J'adore les séries des années 1990 et les enquêtes policières !",
        picture: [mockAttachment],
        favoriteGenreStrings: ["Crime", "Drame", "Thriller"],
        playlistIDs: ["recp6rnl0Vsj0V3Oz", "recNxAIm6HcCZrLgb"],
        favoriteSeries: [breakingBad, sherlock],
        favoriteActors: [bryanCranston, aaronPaul],
        playlists: [playlistHiver]
    )
    static let colette = User(
        lastName: "Briand",
        firstName: "Colette",
        email: "colette.briand@email.com",
        userName: "ColetteB",
        age: 70,
        userBio: "Nuggets à volonté !",
        picture: [mockAttachmentColette],
        favoriteGenreStrings: ["Action & Aventure"],
        favoriteSeries: [breakingBad, peakyBlinders],
        favoriteActors: [bryanCranston, aaronPaul],
        playlists: [playlistHiver]
    )
    
    // MARK: - 8. Événements Calendrier
    
    static func date(day: Int) -> Date {
        var components = DateComponents()
        components.year = 2026
        components.month = 3
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }
    
    static let calendarMocks = [
        CalendarEvent(episodeName: "Mobland", date: date(day: 1), serie: breakingBad),
        CalendarEvent(episodeName: "Le commencement", date: date(day: 3), serie: peakyBlinders),
        CalendarEvent(episodeName: "Chien fou", date: date(day: 5), serie: breakingBad),
        CalendarEvent(episodeName: "Une étude en rose", date: date(day: 7), serie: sherlock),
        CalendarEvent(episodeName: "Le grand jour", date: date(day: 10), serie: peakyBlinders),
        CalendarEvent(episodeName: "Ozymandias", date: date(day: 12), serie: breakingBad),
        CalendarEvent(episodeName: "Le banquier aveugle", date: date(day: 14), serie: sherlock),
        CalendarEvent(episodeName: "La chute", date: date(day: 17), serie: sherlock),
        CalendarEvent(episodeName: "Règlement de comptes", date: date(day: 19), serie: peakyBlinders),
        CalendarEvent(episodeName: "The Gentlemen", date: date(day: 20), serie: breakingBad),
        CalendarEvent(episodeName: "Face à face", date: date(day: 23), serie: breakingBad),
        CalendarEvent(episodeName: "Le dernier vœu", date: date(day: 26), serie: sherlock),
        CalendarEvent(episodeName: "Felina", date: date(day: 28), serie: breakingBad)
    ]
    
    static let allSeries = [breakingBad, peakyBlinders, sherlock]
}
