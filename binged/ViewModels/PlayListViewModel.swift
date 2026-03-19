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
        let newURL = URL(
            string:
                "https://api.airtable.com/v0/appIztQK14x6MyfL9/Playlist/\(id)"
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
            let decoded = try decoder.decode(PlaylistRecord.self, from: data)
            return decoded.fields
        } catch {
            print("Échec du décodage:playlistbyID")
            throw error
        }
    }

    // Récupère l'ID Airtable d'une série par son nom
    func fetchSerieRecordId(named name: String) async -> String? {
        let filter = "filterByFormula={name}='\(name.replacingOccurrences(of: "'", with: "\\'"))'"
        guard let encodedFilter = filter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Serie?\(encodedFilter)") else { return nil }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(Secrets.airtableAPIKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(SeriesResponse.self, from: data)
            return response.records.first?.id
        } catch {
            return nil
        }
    }

    // Met à jour une playlist (Ajout ou Retrait)
    func updatePlaylistSeries(playlistID: String, seriesIDs: [String]) async throws {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Playlist/\(playlistID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(Secrets.airtableAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["fields": ["serie": seriesIDs]]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NSError(domain: "AirtableError", code: httpResponse.statusCode)
        }
    }

    // Crée une nouvelle playlist
    func createPlaylist(name: String, creatorID: String, serieID: String) async throws {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Playlist")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Secrets.airtableAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "fields": [
                "Name": name,
                "creator": [creatorID],
                "serie": [serieID]
            ]
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NSError(domain: "AirtableError", code: httpResponse.statusCode)
        }
    }

    func isSerieInUserPlaylists(serieName: String, user: User, serieVM: SerieViewModels) async -> Bool {
        guard let playlistIDs = user.playlistIDs else { return false }
        
        // 1. On récupère l'ID Airtable de la série qu'on regarde
        guard let targetSerieId = await fetchSerieRecordId(named: serieName) else { return false }
        
        // 2. On parcourt les playlists de l'utilisateur pour voir si cet ID s'y trouve
        for plid in playlistIDs {
            do {
                let playlist = try await getPlayListById(plid)
                if let sIDs = playlist.serieIDs, sIDs.contains(targetSerieId) {
                    return true // Trouvé dans au moins une playlist !
                }
            } catch {
                print("Erreur vérification playlist \(plid)")
            }
        }
        return false
    }
}
