//
//  SerieViewModel.swift
//  binged
//
//  Created by Yannis on 16/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class UserViewModel {

    private let apiKey: String =
        "patnKGmO8SdnHdJuu.56fbd66453984cefbd1b800152e6961547529b65ba18c6cbfdfb838ea9e88c60"
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/User"
    )!
    var users : [User] = []
    
    func getUserById(_ id: String) async throws -> User {
        let newURL = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/User/\(id)")!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(UserResults.self, from: data)
            print(decoded.fields)
            return decoded.fields
        } catch {
            print("Échec du décodage:userbyID")
            throw error
        }
    }
}

