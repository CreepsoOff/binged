import Foundation
import Observation

@Observable @MainActor
class SerieViewModels {

    private let apiKey = Secrets.airtableAPIKey
    var series: [Serie] = []
    var isLoading: Bool = true

    private func createRequest(urlStr: String) -> URLRequest {
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }

    func fetchSeries() async throws {
        isLoading = true
        defer { isLoading = false }
        
        let reqSeries = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Serie")
        let reqRoles = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/ActorSerie")
        
        let reqActors = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Actor")
        
        let reqReviews = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Reviews")

        let (dataSeries, _) = try await URLSession.shared.data(for: reqSeries)
        let (dataRoles, _) = try await URLSession.shared.data(for: reqRoles)
        let (dataActors, _) = try await URLSession.shared.data(for: reqActors)
        let (dataReviews, _) = try await URLSession.shared.data(for: reqReviews)

        let decoder = JSONDecoder()

        // 3. Décodage (On utilise tes structures existantes)
        let decodedSeries = try decoder.decode(SeriesResponse.self, from: dataSeries).records
        let decodedRoles = try decoder.decode(ActorSeriesResponse.self, from: dataRoles).records
        
        // 💡 Ici, Swift va utiliser les CodingKeys de CastMember pour comprendre le JSON de "Actor"
        let decodedActors = try decoder.decode(CastMemberResponse.self, from: dataActors).records
        
        let decodedReviews = try decoder.decode(ReviewResponse.self, from: dataReviews).records

        // --- MAPPING (Reste inchangé) ---
        var dictActors: [String: CastMember] = [:]
        for record in decodedActors {
            dictActors[record.id] = record.fields
        }

        // B. Dictionnaire des Rôles (avec lien Acteur)
        var dictRoles: [String: ActorSerie] = [:]
        for record in decodedRoles {
            var role = record.fields
            if let firstActorID = role.actorIDs?.first {
                role.actor = dictActors[firstActorID]
            }
            dictRoles[record.id] = role
        }
        
        // C. Dictionnaire des Reviews
        var dictReviews: [String: ReviewItem] = [:]
        for record in decodedReviews {
            dictReviews[record.id] = record.fields
        }

        // D. Remplissage des Séries (Rôles + Reviews)
        let finalSeries = decodedSeries.map { $0.fields }
        for serie in finalSeries {
            // Mapping des Acteurs
            if let roleIDs = serie.actorIDs {
                serie.actors = roleIDs.compactMap { dictRoles[$0] }
            }
            
            // Mapping des Reviews (C'est ce qui manquait !)
            if let revIDs = serie.reviewIDs {
                serie.reviews = revIDs.compactMap { dictReviews[$0] }
            }
        }

        self.series = finalSeries
    }
}
