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

    private let apiKey: String = Secrets.airtableAPIKey
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/User"
    )!
    var users : [User] = []
    var currentUser: User?
    
    func getUserById(_ id: String) async throws -> User {
        let newURL = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/User/\(id)")!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(UserRecord.self, from: data)
            return decoded.fields
        } catch {
            throw error
        }
    }
    
    func fetchUsers() async throws {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let response = try decoder.decode(UsersResponse.self, from: data)
        self.users = response.records.map { $0.fields }
    }
}
