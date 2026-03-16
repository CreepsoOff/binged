//
//  Database.swift
//  binged
//

import SwiftUI



// MARK: - Plateformes
let netflix = Platform(name: "Netflix", baseURL: "https://www.netflix.com", icon: "netflix_icon")
let disneyPlus = Platform(name: "Disney+", baseURL: "https://www.disneyplus.com", icon: "disney_icon")
let primeVideo = Platform(name: "Prime Video", baseURL: "https://www.primevideo.com", icon: "prime_icon")
let crunchyroll = Platform(name: "Crunchyroll", baseURL: "https://www.crunchyroll.com", icon: "crunchy_icon")
let hbo = Platform(name: "HBO", baseURL: "https://www.max.com", icon: "hbo_icon")
let appleTV = Platform(name: "Apple TV+", baseURL: "https://www.apple.com/apple-tv-plus/", icon: "appletv_icon")

// MARK: - Décennies & Types
let d2020 = "2020s"
let d2010 = "2010s"
let d2000 = "2000s"
let d1990 = "1990s"

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


// ==========================================
// 1. DÉCLARATION UNIQUE DES ACTEURS
// ==========================================
//
//let timotheeChalamet = CastMember(name: "Timothée Chalamet", imageName: "timothee_chalamet", dateOfBirth: createDate(year: 1995, month: 12, day: 27), cityOfBirth: "New York", bio: "Acteur franco-américain révélé par Call Me by Your Name...")
//let zendaya = CastMember(name: "Zendaya Coleman", imageName: "zendaya", dateOfBirth: createDate(year: 1996, month: 9, day: 1), cityOfBirth: "Oakland", bio: "Actrice et chanteuse américaine connue pour ses rôles dans Euphoria...")
//let leonardoDicaprio = CastMember(name: "Leonardo DiCaprio", imageName: "leonardo_dicaprio", dateOfBirth: createDate(year: 1974, month: 11, day: 11), cityOfBirth: "Los Angeles", bio: "Acteur oscarisé célèbre pour Titanic, Inception...")
//let scarlettJohansson = CastMember(name: "Scarlett Johansson", imageName: "scarlet_johansson", dateOfBirth: createDate(year: 1984, month: 11, day: 22), cityOfBirth: "New York", bio: "Actrice américaine mondialement connue pour son rôle de Black Widow...")
//let robertDowneyJr = CastMember(name: "Robert Downey Jr.", imageName: "downey", dateOfBirth: createDate(year: 1965, month: 4, day: 4), cityOfBirth: "New York", bio: "Acteur iconique ayant incarné Iron Man...")
//let margotRobbie = CastMember(name: "Margot Robbie", imageName: "margot_robbie", dateOfBirth: createDate(year: 1990, month: 7, day: 2), cityOfBirth: "Dalby", bio: "Actrice australienne révélée dans Le Loup de Wall Street...")
//let tomHolland = CastMember(name: "Tom Holland", imageName: "holland", dateOfBirth: createDate(year: 1996, month: 6, day: 1), cityOfBirth: "London", bio: "Acteur britannique connu pour son rôle de Spider-Man...")
//let nataliePortman = CastMember(name: "Natalie Portman", imageName: "natalie_portman", dateOfBirth: createDate(year: 1981, month: 6, day: 9), cityOfBirth: "Jerusalem", bio: "Actrice oscarisée pour Black Swan...")
//let bradPitt = CastMember(name: "Brad Pitt", imageName: "pitt", dateOfBirth: createDate(year: 1963, month: 12, day: 18), cityOfBirth: "Shawnee", bio: "Acteur et producteur américain célèbre pour Fight Club...")
//let emmaStone = CastMember(name: "Emma Stone", imageName: "emma_stone", dateOfBirth: createDate(year: 1988, month: 11, day: 6), cityOfBirth: "Scottsdale", bio: "Actrice américaine oscarisée pour La La Land...")
//
//let haileeSteinfeld = CastMember(name: "Hailee Steinfeld", imageName: "hailee_steinfeld", dateOfBirth: createDate(year: 1996, month: 12, day: 11), cityOfBirth: "Tarzana, USA", bio: "Actrice et chanteuse américaine, célèbre pour Dickinson et Arcane.")
//let ellaPurnell = CastMember(name: "Ella Purnell", imageName: "ella_purnell", dateOfBirth: createDate(year: 1996, month: 9, day: 17), cityOfBirth: "Londres, UK", bio: "Actrice anglaise, connue pour ses rôles dans Yellowjackets, Fallout et Arcane.")
//let jeremyAllenWhite = CastMember(name: "Jeremy Allen White", imageName: "jeremy_allen_white", dateOfBirth: createDate(year: 1991, month: 2, day: 17), cityOfBirth: "New York, USA", bio: "Acteur américain célèbre pour ses rôles dans Shameless et The Bear.")
//let ayoEdebiri = CastMember(name: "Ayo Edebiri", imageName: "ayo_edebiri", dateOfBirth: createDate(year: 1995, month: 10, day: 3), cityOfBirth: "Boston, USA", bio: "Humoriste, actrice et scénariste américaine.")
//let bryanCranston = CastMember(name: "Bryan Cranston", imageName: "bryan_cranston", dateOfBirth: createDate(year: 1956, month: 3, day: 7), cityOfBirth: "Hollywood, USA", bio: "Acteur, réalisateur et producteur américain, inoubliable dans Malcolm et Breaking Bad.")
//let aaronPaul = CastMember(name: "Aaron Paul", imageName: "aaron_paul", dateOfBirth: createDate(year: 1979, month: 8, day: 27), cityOfBirth: "Emmett, USA", bio: "Acteur américain connu mondialement pour le rôle de Jesse Pinkman.")
//let hiroyukiSanada = CastMember(name: "Hiroyuki Sanada", imageName: "hiroyuki_sanada", dateOfBirth: createDate(year: 1960, month: 10, day: 12), cityOfBirth: "Tokyo, Japon", bio: "Acteur et artiste martial japonais reconnu internationalement.")
//let annaSawai = CastMember(name: "Anna Sawai", imageName: "anna_sawai", dateOfBirth: createDate(year: 1992, month: 6, day: 11), cityOfBirth: "Wellington, Nouvelle-Zélande", bio: "Actrice et chanteuse nippo-néo-zélandaise.")
//let yukiKaji = CastMember(name: "Yuki Kaji", imageName: "yuki_kaji", dateOfBirth: createDate(year: 1985, month: 9, day: 3), cityOfBirth: "Tokyo, Japon", bio: "Seiyū (doubleur) et chanteur japonais.")
//let yuiIshikawa = CastMember(name: "Yui Ishikawa", imageName: "yui_ishikawa", dateOfBirth: createDate(year: 1989, month: 5, day: 30), cityOfBirth: "Hyōgo, Japon", bio: "Seiyū (doubleuse) et actrice japonaise.")
//let bryceDallasHoward = CastMember(name: "Bryce Dallas Howard", imageName: "bryce_howard", dateOfBirth: createDate(year: 1981, month: 3, day: 2), cityOfBirth: "Los Angeles, USA", bio: "Actrice et réalisatrice, célèbre pour son rôle dans l'épisode Nosedive de Black Mirror.")
//let karlUrban = CastMember(name: "Karl Urban", imageName: "karl_urban", dateOfBirth: createDate(year: 1972, month: 6, day: 7), cityOfBirth: "Wellington, Nouvelle-Zélande", bio: "Acteur néo-zélandais, interprète de Billy Butcher.")
//let antonyStarr = CastMember(name: "Antony Starr", imageName: "antony_starr", dateOfBirth: createDate(year: 1975, month: 10, day: 25), cityOfBirth: "Auckland, Nouvelle-Zélande", bio: "Acteur néo-zélandais, mondialement connu pour son rôle du Protecteur (Homelander).")
//let stevenYeun = CastMember(name: "Steven Yeun", imageName: "steven_yeun", dateOfBirth: createDate(year: 1983, month: 12, day: 21), cityOfBirth: "Séoul, Corée du Sud", bio: "Acteur sud-coréen naturalisé américain, révélé par The Walking Dead.")
//let aliWong = CastMember(name: "Ali Wong", imageName: "ali_wong", dateOfBirth: createDate(year: 1982, month: 4, day: 19), cityOfBirth: "San Francisco, USA", bio: "Humoriste de stand-up, actrice et scénariste américaine.")
//let jasonSudeikis = CastMember(name: "Jason Sudeikis", imageName: "jason_sudeikis", dateOfBirth: createDate(year: 1975, month: 9, day: 18), cityOfBirth: "Fairfax, USA", bio: "Acteur, humoriste et scénariste américain.")
//let brettGoldstein = CastMember(name: "Brett Goldstein", imageName: "brett_goldstein", dateOfBirth: createDate(year: 1980, month: 7, day: 17), cityOfBirth: "Sutton, UK", bio: "Acteur, humoriste et scénariste britannique, interprète de Roy Kent.")
//
//let cillianMurphy = CastMember(name: "Cillian Murphy", imageName: "cillian_murphy", dateOfBirth: createDate(year: 1976, month: 5, day: 25), cityOfBirth: "Douglas, Irlande", bio: "Acteur irlandais, oscarisé pour Oppenheimer et star de Peaky Blinders.")
//let paulAnderson = CastMember(name: "Paul Anderson", imageName: "paul_anderson", dateOfBirth: createDate(year: 1978, month: 2, day: 12), cityOfBirth: "Londres, UK", bio: "Acteur britannique, célèbre pour son rôle d'Arthur Shelby.")
//let tomHardy = CastMember(name: "Tom Hardy", imageName: "tom_hardy", dateOfBirth: createDate(year: 1977, month: 9, day: 15), cityOfBirth: "Londres, UK", bio: "Acteur et producteur britannique au charisme imposant.")
//let helenMcCrory = CastMember(name: "Helen McCrory", imageName: "helen_mccrory", dateOfBirth: createDate(year: 1968, month: 8, day: 17), cityOfBirth: "Londres, UK", bio: "Actrice britannique de grand talent, regrettée pour son rôle de Polly Gray.")

// ==========================================
// 2. TABLEAU GLOBAL DES ACTEURS
// ==========================================

//let allActors: [CastMember] = [
//    timotheeChalamet, zendaya, leonardoDicaprio, scarlettJohansson, robertDowneyJr,
//    margotRobbie, tomHolland, nataliePortman, bradPitt, emmaStone,
//    haileeSteinfeld, ellaPurnell, jeremyAllenWhite, ayoEdebiri,
//    bryanCranston, aaronPaul, hiroyukiSanada, annaSawai,
//    yukiKaji, yuiIshikawa, bryceDallasHoward,
//    karlUrban, antonyStarr, stevenYeun, aliWong,
//    jasonSudeikis, brettGoldstein,
//    cillianMurphy, paulAnderson, tomHardy, helenMcCrory
//]

// ==========================================
// 3. TABLEAU DES SÉRIES
// ==========================================



//var seriesT: [Serie] = [
//    
//    // ARCANE
//    Serie(
//        name: "Arcane",
//        desc: "Au milieu du conflit entre les villes jumelles de Piltover et Zaun, deux sœurs se battent dans les camps opposés d'une guerre technologique.",
//        type: standard,
//        cover: "arcane_cover",
//        year: 2021,
//        decennie: d2020,
//        genre: .animation,
//        actors: [
//            ActorSerie(actor: haileeSteinfeld, roleName: "Vi"),
//            ActorSerie(actor: ellaPurnell, roleName: "Jinx")
//        ],
//        platform: [netflix],
//        nbSaisons: 2,
//        nbEpisodes: 18,
//        inProgress: true
//    ),
//
//    // THE BEAR
//    Serie(
//        name: "The Bear",
//        desc: "Un jeune chef cuisinier issu du monde de la haute gastronomie rentre à Chicago pour gérer la sandwicherie de sa famille.",
//        type: standard,
//        cover: "the_bear_cover",
//        year: 2022,
//        decennie: d2020,
//        genre: .drama,
//        actors: [
//            ActorSerie(actor: jeremyAllenWhite, roleName: "Carmen 'Carmy' Berzatto"),
//            ActorSerie(actor: ayoEdebiri, roleName: "Sydney Adamu")
//        ],
//        platform: [disneyPlus],
//        nbSaisons: 3,
//        nbEpisodes: 28
//    ),
//
//    // BREAKING BAD
//    Serie(
//        name: "Breaking Bad",
//        desc: "Un professeur de chimie atteint d'un cancer s'associe à un ancien élève pour fabriquer et vendre de la méthamphétamine.",
//        type: standard,
//        cover: "breaking_bad_cover",
//        year: 2008,
//        decennie: d2000,
//        genre: .crime,
//        actors: [
//            ActorSerie(actor: bryanCranston, roleName: "Walter White"),
//            ActorSerie(actor: aaronPaul, roleName: "Jesse Pinkman")
//        ],
//        platform: [netflix],
//        nbSaisons: 5,
//        nbEpisodes: 62
//    ),
//
//    // SHŌGUN
//    Serie(
//        name: "Shōgun",
//        desc: "En 1600 au Japon, Lord Yoshii Toranaga lutte pour sa survie alors que ses ennemis au Conseil des régents se liguent contre lui.",
//        type: mini,
//        cover: "shogun_cover",
//        year: 2024,
//        decennie: d2020,
//        genre: .history,
//        actors: [
//            ActorSerie(actor: hiroyukiSanada, roleName: "Lord Yoshii Toranaga"),
//            ActorSerie(actor: annaSawai, roleName: "Toda Mariko")
//        ],
//        platform: [disneyPlus],
//        nbSaisons: 1,
//        nbEpisodes: 10
//    ),
//
//    // ATTACK ON TITAN
//    Serie(
//        name: "Attack on Titan",
//        desc: "L'humanité vit retranchée derrière d'immenses murs pour se protéger de prédateurs géants appelés Titans.",
//        type: standard,
//        cover: "aot_cover",
//        year: 2013,
//        decennie: d2010,
//        genre: .anime,
//        actors: [
//            ActorSerie(actor: yukiKaji, roleName: "Eren Yeager (Voix)"),
//            ActorSerie(actor: yuiIshikawa, roleName: "Mikasa Ackerman (Voix)")
//        ],
//        platform: [crunchyroll, netflix],
//        nbSaisons: 4,
//        nbEpisodes: 88
//    ),
//
//    // BLACK MIRROR
//    Serie(
//        name: "Black Mirror",
//        desc: "Une série d'anthologie qui explore un futur proche high-tech où les plus belles innovations de l'humanité se heurtent à ses bas instincts.",
//        type: anthology,
//        cover: "black_mirror_cover",
//        year: 2011,
//        decennie: d2010,
//        genre: .sf,
//        actors: [
//            ActorSerie(actor: bryceDallasHoward, roleName: "Lacie Pound")
//        ],
//        platform: [netflix],
//        nbSaisons: 6,
//        nbEpisodes: 27
//    ),
//    
//    // THE BOYS
//    Serie(
//        name: "The Boys",
//        desc: "Dans un monde où les super-héros sont corrompus par la célébrité, un groupe de justiciers entreprend de les abattre.",
//        type: standard,
//        cover: "the_boys_cover",
//        year: 2019,
//        decennie: d2010,
//        genre: .action,
//        actors: [
//            ActorSerie(actor: karlUrban, roleName: "William 'Billy' Butcher"),
//            ActorSerie(actor: antonyStarr, roleName: "Le Protecteur / Homelander")
//        ],
//        platform: [primeVideo],
//        nbSaisons: 4,
//        nbEpisodes: 32
//    ),
//
//    // BEEF (ACHARNÉS)
//    Serie(
//        name: "Beef",
//        desc: "Un incident de la route entre deux inconnus tourne à l'obsession et commence à consumer leur vie petit à petit.",
//        type: mini,
//        cover: "beef_cover",
//        year: 2023,
//        decennie: d2020,
//        genre: .comedy,
//        actors: [
//            ActorSerie(actor: stevenYeun, roleName: "Danny Cho"),
//            ActorSerie(actor: aliWong, roleName: "Amy Lau")
//        ],
//        platform: [netflix],
//        nbSaisons: 1,
//        nbEpisodes: 10
//    ),
//
//    // TED LASSO
//    Serie(
//        name: "Ted Lasso",
//        desc: "Un coach de football américain est recruté pour entraîner une équipe de football (soccer) à Londres, sans aucune expérience.",
//        type: standard,
//        cover: "ted_lasso_cover",
//        year: 2020,
//        decennie: d2020,
//        genre: .comedy,
//        actors: [
//            ActorSerie(actor: jasonSudeikis, roleName: "Ted Lasso"),
//            ActorSerie(actor: brettGoldstein, roleName: "Roy Kent")
//        ],
//        platform: [appleTV],
//        nbSaisons: 3,
//        nbEpisodes: 34
//    ),
//    
//    // PEAKY BLINDERS (Ajoutée pour compléter les acteurs fournis !)
//    Serie(
//        name: "Peaky Blinders",
//        desc: "Birmingham, en 1919. Un gang familial règne sur un quartier de la ville : les Peaky Blinders, ainsi nommés pour les lames de rasoir qu'ils cachent dans la visière de leur casquette.",
//        type: standard,
//        cover: "peakyblinders",
//        year: 2013,
//        decennie: d2010,
//        genre: .crime,
//        actors: [
//            ActorSerie(actor: cillianMurphy, roleName: "Tommy Shelby"),
//            ActorSerie(actor: paulAnderson, roleName: "Arthur Shelby"),
//            ActorSerie(actor: tomHardy, roleName: "Alfie Solomons"),
//            ActorSerie(actor: helenMcCrory, roleName: "Polly Gray")
//        ],
//        platform: [netflix],
//        nbSaisons: 6,
//        nbEpisodes: 36
//    )
//]

