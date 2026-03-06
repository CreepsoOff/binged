//
//  User.swift
//  binged
//
//  Created by Apprenant 92 on 04/03/2026.
//

import Foundation

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

var magalie = User(
    lastName: "Piquet",
    firstName: "Magalie",
    Username: "Piquima",
    email: "Magalie@lecercle.mali",
    picture: "magalie",
    age: 70,
    userBio: "j'adore les séries des années 1990",
//  favoriteGenre: [.ScienceFiction, .torror, .thriller]
//    favoriteSeries: [.PeakyBlinder, .the100, .Sherlock],
//    favoriteActor: [.BradPit, .RobertDeniro, .EmaWatson],
 //   posts: postsMagalie
)
