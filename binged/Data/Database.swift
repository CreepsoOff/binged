//
//  Database.swift
//  binged
//
//  Created by apprenant85 on 05/03/2026.
//

import SwiftUI

let listDesDecennies = [
    YearSerie(value: "2020s"),
    YearSerie(value: "2010s"),
    YearSerie(value: "2000s"),
    YearSerie(value: "1990s"),
    YearSerie(value: "1980s"),
    YearSerie(value: "1970s"),
    YearSerie(value: "1960s"),
    YearSerie(value: "1950s"),
    YearSerie(value: "1940s")
]

// Plateformes
let netflix = Platform(name: "Netflix", baseURL: "https://www.netflix.com", icon: "netflix_icon")
let disneyPlus = Platform(name: "Disney+", baseURL: "https://www.disneyplus.com", icon: "disney_icon")
let primeVideo = Platform(name: "Prime Video", baseURL: "https://www.primevideo.com", icon: "prime_icon")
let crunchyroll = Platform(name: "Crunchyroll", baseURL: "https://www.crunchyroll.com", icon: "crunchy_icon")
let hbo = Platform(name: "HBO", baseURL: "https://www.max.com", icon: "hbo_icon")
let appleTV = Platform(name: "Apple TV+", baseURL: "https://www.apple.com/apple-tv-plus/", icon: "appletv_icon")

// Décennies
let d2020 = YearSerie(value: "2020s")
let d2010 = YearSerie(value: "2010s")
let d2000 = YearSerie(value: "2000s")
let d1990 = YearSerie(value: "1990s")

// Types de série
let standard = SerieType(kind: .standard)
let mini = SerieType(kind: .mini)
let anthology = SerieType(kind: .anthology)

var series: [Serie] = [

    Serie(
        name: "Arcane",
        desc: "Au milieu du conflit entre Piltover et Zaun, deux sœurs se battent dans les camps opposés d'une guerre technologique.",
        type: SerieType(kind: .standard),
        cover: "arcane_cover",
        year: 2021,
        decennie: YearSerie(value: "2020"),
        genre: Genre(type: .animation),
        actors: [],
        platform: [netflix],
        nbSaisons: 2,
        nbEpisodes: 18,
        inProgress: true
    ),

    Serie(
        name: "The Bear",
        desc: "Un jeune chef cuisinier issu du monde de la haute gastronomie rentre à Chicago pour gérer la sandwicherie familiale.",
        type: SerieType(kind: .standard),
        cover: "the_bear_cover",
        year: 2022,
        decennie: YearSerie(value: "2020"),
        genre: Genre(type: .drama),
        actors: [],
        platform: [disneyPlus],
        nbSaisons: 3,
        nbEpisodes: 28
    ),

    Serie(
        name: "Breaking Bad",
        desc: "Un professeur de chimie atteint d'un cancer s'associe à un ancien élève pour fabriquer et vendre de la méthamphétamine.",
        type: SerieType(kind: .standard),
        cover: "breaking_bad_cover",
        year: 2008,
        decennie: YearSerie(value: "2000"),
        genre: Genre(type: .crime),
        actors: [],
        platform: [netflix],
        nbSaisons: 5,
        nbEpisodes: 62
    ),

    Serie(
        name: "Shōgun",
        desc: "En 1600 au Japon, Lord Yoshii Toranaga lutte pour sa survie alors que ses ennemis se liguent contre lui.",
        type: SerieType(kind: .mini),
        cover: "shogun_cover",
        year: 2024,
        decennie: YearSerie(value: "2020"),
        genre: Genre(type: .history),
        actors: [],
        platform: [disneyPlus],
        nbSaisons: 1,
        nbEpisodes: 10
    ),

    Serie(
        name: "Attack on Titan",
        desc: "L'humanité vit retranchée derrière d'immenses murs pour se protéger des Titans.",
        type: SerieType(kind: .standard),
        cover: "aot_cover",
        year: 2013,
        decennie: YearSerie(value: "2010"),
        genre: Genre(type: .anime),
        actors: [],
        platform: [crunchyroll, netflix],
        nbSaisons: 4,
        nbEpisodes: 88
    ),

    Serie(
        name: "Black Mirror",
        desc: "Anthologie explorant un futur proche où les technologies se retournent contre l'humanité.",
        type: SerieType(kind: .anthology),
        cover: "black_mirror_cover",
        year: 2011,
        decennie: YearSerie(value: "2010"),
        genre: Genre(type: .sf),
        actors: [],
        platform: [netflix],
        nbSaisons: 6,
        nbEpisodes: 27
    ),

    Serie(
        name: "The Boys",
        desc: "Des super-héros corrompus sont combattus par un groupe de justiciers.",
        type: SerieType(kind: .standard),
        cover: "the_boys_cover",
        year: 2019,
        decennie: YearSerie(value: "2010"),
        genre: Genre(type: .action),
        actors: [],
        platform: [primeVideo],
        nbSaisons: 4,
        nbEpisodes: 32
    ),

    Serie(
        name: "Beef",
        desc: "Un incident de la route dégénère et consume progressivement la vie de deux inconnus.",
        type: SerieType(kind: .mini),
        cover: "beef_cover",
        year: 2023,
        decennie: YearSerie(value: "2020"),
        genre: Genre(type: .comedy),
        actors: [],
        platform: [netflix],
        nbSaisons: 1,
        nbEpisodes: 10
    ),

    Serie(
        name: "Ted Lasso",
        desc: "Un coach de football américain entraîne une équipe de football anglaise sans aucune expérience.",
        type: SerieType(kind: .standard),
        cover: "ted_lasso_cover",
        year: 2020,
        decennie: YearSerie(value: "2020"),
        genre: Genre(type: .comedy),
        actors: [],
        platform: [appleTV],
        nbSaisons: 3,
        nbEpisodes: 34
    )
]
