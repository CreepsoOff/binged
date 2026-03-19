//
//  SerieViewModel.swift
//  binged
//
//  Created by Apprenant 92 on 18/03/2026.
//

import Foundation
import Observation

//@Observable @MainActor
struct SerieViewModel {
    func getSerieById(_ id: String) async throws -> Serie {
        let newURL = URL(
            string:
                "https://api.airtable.com/v0/appIztQK14x6MyfL9/Serie/\(id)"
        )!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue(
            "Bearer \(Secrets.airtableAPIKey)",
            forHTTPHeaderField: "Authorization"
        )

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(SerieRecord.self, from: data)
            print(decoded.fields)
            return decoded.fields
        } catch {
            print("Échec du décodage: serieByID")
            throw error
        }
    }
}
