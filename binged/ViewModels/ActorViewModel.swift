//
//  SerieViewModel.swift
//  binged
//
//  Created by Yannis on 16/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class ActorViewModel {

    private let apiKey: String =
        "patnKGmO8SdnHdJuu.56fbd66453984cefbd1b800152e6961547529b65ba18c6cbfdfb838ea9e88c60"
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Actor"
    )!
    
    func getActorById(_ id: String) async throws -> Actor {
        let newURL = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Actor/\(id)")!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let isoFormatter = ISO8601DateFormatter()
            if let date = isoFormatter.date(from: dateString) {
                return date
            }

            let dateFormatter = DateFormatter()
            dateFormatter.calendar = Calendar(identifier: .iso8601)
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "yyyy-MM-dd"

            if let date = dateFormatter.date(from: dateString) {
                return date
            }

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
        }

        do {
            let decoded = try decoder.decode(ActorResults.self, from: data)
            print(decoded.fields)
            return decoded.fields
        } catch {
            print("Échec du décodage:ActorbyID")
            throw error
        }
    }
}

