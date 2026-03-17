////
////  Actor.swift
////  binged
////
////  Created by Apprenant 92 on 06/03/2026.
////
//
//import Foundation
//
//struct ActorResults: Codable {
//    let fields: Actor
//}
//
//struct Actor: Codable{
//    var actorName: String
//    var actorImage: String
//    var actorDateOfBirth: Date
//    var actorCityOfBirth: String
//    var actorBio: String
////    var actorFilmographie: String
//    var actorAge: Int {
//           Calendar.current.dateComponents([.year], from: actorDateOfBirth, to: Date()).year!
//    }
//}
//
////let actors: [Actor] = [
////
////    Actor(
////        actorFirstName: "Timothée",
////        actorImage: "chalamet",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1995, month: 12, day: 27))!,
////        actorCityOfBirth: "New York",
////        actorBio: "Acteur franco-américain révélé par Call Me by Your Name. Il est reconnu pour son jeu sensible et sa présence dans de nombreux films d’auteur et blockbusters récents."
////    ),
////
////    Actor(
////        actorFirstName: "Zendaya",
////        actorLastName: "Coleman",
////        actorImage: "zendaya",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1996, month: 9, day: 1))!,
////        actorCityOfBirth: "Oakland",
////        actorBio: "Actrice et chanteuse américaine connue pour ses rôles dans Euphoria et la saga Spider-Man. Elle est appréciée pour son intensité dramatique et son charisme."
////    ),
////
////    Actor(
////        actorFirstName: "Leonardo",
////        actorLastName: "DiCaprio",
////        actorImage: "dicaprio",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1974, month: 11, day: 11))!,
////        actorCityOfBirth: "Los Angeles",
////        actorBio: "Acteur oscarisé célèbre pour Titanic, Inception et The Revenant. Il est également engagé dans la protection de l’environnement."
////    ),
////
////    Actor(
////        actorFirstName: "Scarlett",
////        actorLastName: "Johansson",
////        actorImage: "scarlett",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1984, month: 11, day: 22))!,
////        actorCityOfBirth: "New York",
////        actorBio: "Actrice américaine mondialement connue pour son rôle de Black Widow dans l’univers Marvel et pour sa carrière dans le cinéma indépendant."
////    ),
////
////    Actor(
////        actorFirstName: "Robert",
////        actorLastName: "Downey Jr.",
////        actorImage: "downey",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1965, month: 4, day: 4))!,
////        actorCityOfBirth: "New York",
////        actorBio: "Acteur iconique ayant incarné Iron Man dans le Marvel Cinematic Universe. Sa carrière s’étend sur plusieurs décennies avec de nombreux rôles marquants."
////    ),
////
////    Actor(
////        actorFirstName: "Margot",
////        actorLastName: "Robbie",
////        actorImage: "robbie",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1990, month: 7, day: 2))!,
////        actorCityOfBirth: "Dalby",
////        actorBio: "Actrice australienne révélée dans Le Loup de Wall Street. Elle est également productrice et a joué dans des films comme Barbie et I, Tonya."
////    ),
////
////    Actor(
////        actorFirstName: "Tom",
////        actorLastName: "Holland",
////        actorImage: "holland",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1996, month: 6, day: 1))!,
////        actorCityOfBirth: "London",
////        actorBio: "Acteur britannique connu pour son rôle de Spider-Man dans le Marvel Cinematic Universe. Il a commencé sa carrière dans la danse et la comédie musicale."
////    ),
////
////    Actor(
////        actorFirstName: "Natalie",
////        actorLastName: "Portman",
////        actorImage: "portman",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1981, month: 6, day: 9))!,
////        actorCityOfBirth: "Jerusalem",
////        actorBio: "Actrice oscarisée pour Black Swan. Elle est reconnue pour ses performances intenses et sa carrière mêlant films indépendants et grosses productions."
////    ),
////
////    Actor(
////        actorFirstName: "Brad",
////        actorLastName: "Pitt",
////        actorImage: "pitt",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1963, month: 12, day: 18))!,
////        actorCityOfBirth: "Shawnee",
////        actorBio: "Acteur et producteur américain célèbre pour Fight Club, Seven et Once Upon a Time in Hollywood. Il a remporté plusieurs Oscars."
////    ),
////
////    Actor(
////        actorFirstName: "Emma",
////        actorLastName: "Stone",
////        actorImage: "stone",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1988, month: 11, day: 6))!,
////        actorCityOfBirth: "Scottsdale",
////        actorBio: "Actrice américaine oscarisée pour La La Land. Elle est connue pour sa polyvalence entre comédie, drame et films indépendants."
////    ),
////    Actor(
////            actorFirstName: "Cillian",
////            actorLastName: "Murphy",
////            actorImage: "murphy",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1976, month: 5, day: 25))!,
////            actorCityOfBirth: "Douglas",
////            actorBio: "Acteur irlandais célèbre pour son rôle de Thomas Shelby dans Peaky Blinders et pour ses collaborations avec Christopher Nolan."
////        ),
////
////        Actor(
////            actorFirstName: "Anya",
////            actorLastName: "Taylor-Joy",
////            actorImage: "taylorjoy",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1996, month: 4, day: 16))!,
////            actorCityOfBirth: "Miami",
////            actorBio: "Actrice révélée par la série Le Jeu de la Dame et par des films comme The Witch et Furiosa."
////        ),
////
////        Actor(
////            actorFirstName: "Pedro",
////            actorLastName: "Pascal",
////            actorImage: "pascal",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1975, month: 4, day: 2))!,
////            actorCityOfBirth: "Santiago",
////            actorBio: "Acteur chilien connu pour ses rôles dans The Last of Us, Narcos et The Mandalorian."
////        ),
////
////        Actor(
////            actorFirstName: "Jenna",
////            actorLastName: "Ortega",
////            actorImage: "ortega",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 2002, month: 9, day: 27))!,
////            actorCityOfBirth: "Coachella Valley",
////            actorBio: "Actrice américaine devenue célèbre grâce à la série Wednesday et à plusieurs films d’horreur."
////        ),
////
////        Actor(
////            actorFirstName: "Millie",
////            actorLastName: "Bobby Brown",
////            actorImage: "millie",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 2004, month: 2, day: 19))!,
////            actorCityOfBirth: "Marbella",
////            actorBio: "Actrice britannique révélée par son rôle d’Eleven dans Stranger Things."
////        ),
////
////        Actor(
////            actorFirstName: "Henry",
////            actorLastName: "Cavill",
////            actorImage: "cavill",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1983, month: 5, day: 5))!,
////            actorCityOfBirth: "Saint Helier",
////            actorBio: "Acteur britannique connu pour Superman et pour son rôle de Geralt dans The Witcher."
////        ),
////
////        Actor(
////            actorFirstName: "Emilia",
////            actorLastName: "Clarke",
////            actorImage: "clarke",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1986, month: 10, day: 23))!,
////            actorCityOfBirth: "London",
////            actorBio: "Actrice célèbre pour son rôle de Daenerys Targaryen dans Game of Thrones."
////        ),
////
////        Actor(
////            actorFirstName: "Kit",
////            actorLastName: "Harington",
////            actorImage: "harington",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1986, month: 12, day: 26))!,
////            actorCityOfBirth: "London",
////            actorBio: "Acteur britannique connu pour son rôle de Jon Snow dans Game of Thrones."
////        ),
////
////        Actor(
////            actorFirstName: "Bryan",
////            actorLastName: "Cranston",
////            actorImage: "cranston",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1956, month: 3, day: 7))!,
////            actorCityOfBirth: "Hollywood",
////            actorBio: "Acteur américain célèbre pour son rôle de Walter White dans Breaking Bad."
////        ),
////
////        Actor(
////            actorFirstName: "Aaron",
////            actorLastName: "Paul",
////            actorImage: "paul",
////            actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1979, month: 8, day: 27))!,
////            actorCityOfBirth: "Emmett",
////            actorBio: "Acteur américain connu pour son rôle de Jesse Pinkman dans Breaking Bad."
////        ),
////    Actor(
////        actorFirstName: "Paul",
////        actorLastName: "Anderson",
////        actorImage: "anderson",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1978, month: 2, day: 12))!,
////        actorCityOfBirth: "London",
////        actorBio: "Acteur britannique connu pour son rôle d’Arthur Shelby dans la série Peaky Blinders."
////    ),
////
////    Actor(
////        actorFirstName: "Helen",
////        actorLastName: "mccrory",
////        actorImage: "mccrory",
////        actorDateOfBirth: Calendar.current.date(from: DateComponents(year: 1968, month: 8, day: 17))!,
////        actorCityOfBirth: "London",
////        actorBio: "Actrice britannique célèbre pour son rôle de Polly Gray dans Peaky Blinders et Narcissa Malefoy dans Harry Potter."
////    )
////]
