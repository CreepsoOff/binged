//
//  SerieViewModel.swift
//  binged
//
//  Created by Yannis on 16/03/2026.
//

import Foundation
import Observation

@Observable @MainActor
class PlayListViewModel {
    func getPlayListById(_ id: String) async throws -> Playlist {
        let newURL = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Playlist/\(id)")!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Secrets.airtableAPIKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(PlaylistRecord.self, from: data)
            return decoded.fields
        } catch {
            throw error
        }
    }
}
