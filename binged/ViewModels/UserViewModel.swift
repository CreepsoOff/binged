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
    
    func getUserById(_ id: String) async throws -> User {
        let newURL = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/User/\(id)")!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Secrets.airtableAPIKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(UserRecord.self, from: data)
            print(decoded.fields)
            return decoded.fields
        } catch {
            print("Échec du décodage:userbyID")
            throw error
        }
    }
}

