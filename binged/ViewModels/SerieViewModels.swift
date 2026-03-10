import Foundation
import Observation

@Observable @MainActor
class SerieViewModels {

    private let apiKey: String =
        "patnKGmO8SdnHdJuu.56fbd66453984cefbd1b800152e6961547529b65ba18c6cbfdfb838ea9e88c60"
    private let baseURL = URL(
        string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Série"
    )!
    var series: [Serie] = []

   

    func fetchSeries() async throws {

        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(SeriesResponse.self, from: data)
            let decodedSeries = decoded.records.map { $0.fields }
            self.series = decodedSeries
        } catch {
            print("Échec du décodage: \(error)")
            throw error
        }
        
    }
}
