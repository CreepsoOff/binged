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

/* import Foundation
import Observation

@Observable @MainActor
class UserViewModel {
    
    var users: [User] = []
    var isLoading: Bool = true
    
    // Si tu as bien créé le fichier Secrets.swift, sinon remets ta clé en dur (String) pour l'instant
    private let apiKey = Secrets.airtableAPIKey 
    
    func fetchUsers() async throws {
        isLoading = true
        defer { isLoading = false }
        
        // Assure-toi que "User" est bien le nom exact de ta table sur Airtable
        guard let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/User") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(UsersResponse.self, from: data)
            
            self.users = response.records.map { $0.fields }
            print("✅ \(self.users.count) utilisateur(s) téléchargé(s) !")
            
        } catch {
            print("❌ Erreur de téléchargement des utilisateurs : \(error)")
        }
    }
} */

