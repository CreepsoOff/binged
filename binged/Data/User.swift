//
//  User.swift
//  binged
//
//  Created by Apprenant 92 on 04/03/2026.
//

import Foundation

let allGenres: [Genre] = GenreType.allCases.map { Genre(type: $0) }
let allSeries = series
let allActors = actors

var magalie = User(
    lastName: "Piquet",
    firstName: "Magalie",
    Username: "Piquima",
    email: "Magalie@lecercle.mali",
    picture: "magalie",
    age: 70,
    userBio: "j'adore les séries des années 1990",
    favoriteGenre: [Genre(type: .action)],
    favoriteSerie: [series[0]],
    favoriteActor: [actors[0], actors[1], actors[2]]
)

var colette = User(
    lastName: "Fournier",
    firstName: "Colette",
    Username: "Colette",
    email: "colette@lecercle.mali",
    picture: "colette",
    age: 71,
    userBio: "Sportive dans l’âme, je trouve mon équilibre entre la randonnée, la pêche et le plaisir de cuisiner. J’aime les moments simples, en pleine nature ou autour d’un bon repas",
    favoriteGenre: [Genre(type: .action)],
    favoriteSerie: [series[0]],
    favoriteActor: [actors[3], actors[4], actors[5]]
)
