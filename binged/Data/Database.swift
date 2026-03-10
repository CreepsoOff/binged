//
//  Database.swift
//  binged
//
//  Created by apprenant85 on 05/03/2026.
//

import SwiftUI

//let listDesDecennies = [
//    YearSerie(value: "2020s"), YearSerie(value: "2010s"),
//    YearSerie(value: "2000s"), YearSerie(value: "1990s"),
//    YearSerie(value: "1980s"), YearSerie(value: "1970s"),
//    YearSerie(value: "1960s"), YearSerie(value: "1950s"),
//]

// Plateformes
let netflix = Platform(
    name: "Netflix",
    baseURL: "https://www.netflix.com",
    icon: "netflix_icon"
)
let disneyPlus = Platform(
    name: "Disney+",
    baseURL: "https://www.disneyplus.com",
    icon: "disney_icon"
)
let primeVideo = Platform(
    name: "Prime Video",
    baseURL: "https://www.primevideo.com",
    icon: "prime_icon"
)
let crunchyroll = Platform(
    name: "Crunchyroll",
    baseURL: "https://www.crunchyroll.com",
    icon: "crunchy_icon"
)
let hbo = Platform(
    name: "HBO",
    baseURL: "https://www.max.com",
    icon: "hbo_icon"
)
let appleTV = Platform(
    name: "Apple TV+",
    baseURL: "https://www.apple.com/apple-tv-plus/",
    icon: "appletv_icon"
)




// Décennies
let d2020 = "2020s"
let d2010 = "2010s"
let d2000 = "2000s"
let d1990 = "1990s"

// Types de série
let standard = Kind.standard
let mini = Kind.mini
let anthology = Kind.anthology

var seriesT: [Serie] = [
    Serie(
        name: "Arcane",
        desc:
            "Au milieu du conflit entre les villes jumelles de Piltover et Zaun, deux sœurs se battent dans les camps opposés d'une guerre technologique.",
        type: standard,
        cover: "arcane_cover",
        year: 2021,
        decennie: d2020,
        genre: .animation,
        actors: [],
        platform: [netflix],
        nbSaisons: 2,
        nbEpisodes: 18,
        inProgress: true
    ),

    Serie(
        name: "The Bear",
        desc:
            "Un jeune chef cuisinier issu du monde de la haute gastronomie rentre à Chicago pour gérer la sandwicherie de sa famille.",
        type: standard,
        cover: "the_bear_cover",
        year: 2022,
        decennie: d2020,
        genre: .drama,
        actors: [],
        platform: [disneyPlus],
        nbSaisons: 3,
        nbEpisodes: 28
    ),

    Serie(
        name: "Breaking Bad",
        desc:
            "Un professeur de chimie atteint d'un cancer s'associe à un ancien élève pour fabriquer et vendre de la méthamphétamine.",
        type: standard,
        cover: "breaking_bad_cover",
        year: 2008,
        decennie: d2000,
        genre: .crime,
        actors: [],
        platform: [netflix],
        nbSaisons: 5,
        nbEpisodes: 62
    ),

    Serie(
        name: "Shōgun",
        desc:
            "En 1600 au Japon, Lord Yoshii Toranaga lutte pour sa survie alors que ses ennemis au Conseil des régents se liguent contre lui.",
        type: mini,
        cover: "shogun_cover",
        year: 2024,
        decennie: d2020,
        genre: .history,
        actors: [],
        platform: [disneyPlus],
        nbSaisons: 1,
        nbEpisodes: 10
    ),

    Serie(
        name: "Attack on Titan",
        desc:
            "L'humanité vit retranchée derrière d'immenses murs pour se protéger de prédateurs géants appelés Titans.",
        type: standard,
        cover: "aot_cover",
        year: 2013,
        decennie: d2010,
        genre: .anime,
        actors: [],
        platform: [crunchyroll, netflix],
        nbSaisons: 4,
        nbEpisodes: 88
    ),

    Serie(
        name: "Black Mirror",
        desc:
            "Une série d'anthologie qui explore un futur proche high-tech où les plus belles innovations de l'humanité se heurtent à ses bas instincts.",
        type: anthology,
        cover: "black_mirror_cover",
        year: 2011,
        decennie: d2010,
        genre: .sf,
        actors: [],
        platform: [netflix],
        nbSaisons: 6,
        nbEpisodes: 27
    ),
    // THE BOYS
    Serie(
        name: "The Boys",
        desc:
            "Dans un monde où les super-héros sont corrompus par la célébrité, un groupe de justiciers entreprend de les abattre.",
        type: standard,
        cover: "the_boys_cover",
        year: 2019,
        decennie: d2010,
        genre: .action,
        actors: [],
        platform: [primeVideo],
        nbSaisons: 4,
        nbEpisodes: 32
    ),

    // BEEF (ACHARNÉS)
    Serie(
        name: "Beef",
        desc:
            "Un incident de la route entre deux inconnus tourne à l'obsession et commence à consumer leur vie petit à petit.",
        type: mini,
        cover: "beef_cover",
        year: 2023,
        decennie: d2020,
        genre: .comedy,
        actors: [],
        platform: [netflix],
        nbSaisons: 1,
        nbEpisodes: 10
    ),

    // TED LASSO
    Serie(
        name: "Ted Lasso",
        desc:
            "Un coach de football américain est recruté pour entraîner une équipe de football (soccer) à Londres, sans aucune expérience.",
        type: standard,
        cover: "ted_lasso_cover",
        year: 2020,
        decennie: d2020,
        genre: .comedy,
        actors: [],
        platform: [appleTV],
        nbSaisons: 3,
        nbEpisodes: 34
    ),
]



