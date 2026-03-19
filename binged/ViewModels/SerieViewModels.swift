import Foundation
import Observation

@Observable @MainActor
class SerieViewModels {

    private let apiKey = Secrets.airtableAPIKey
    var series: [Serie] = []
    var allActors: [CastMember] = []
    var allPlatforms: [Platform] = []
    var platformIDToName: [String: String] = [:]
    var events: [CalendarEvent] = []
    var isLoading: Bool = true

    private func createRequest(urlStr: String) -> URLRequest {
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func getSerieById(_ id: String) async throws -> Serie {
        let newURL = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Serie/\(id)")!
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Secrets.airtableAPIKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let decoded = try decoder.decode(SerieRecord.self, from: data)
            return decoded.fields
        } catch {
            throw error
        }
    }
    
    // MARK: - FETCH PAR ID (Lazy Loading)
        
    func getPlatformById(_ id: String) async throws -> Platform {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Platform/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(PlatformRecord.self, from: data).fields
    }

    func getReviewById(_ id: String) async throws -> ReviewItem {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Reviews/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ReviewRecord.self, from: data).fields
    }

    func getRoleById(_ id: String) async throws -> ActorSerie {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/ActorSerie/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ActorSerieRecord.self, from: data).fields
    }
    
    func getActorById(_ id: String) async throws -> CastMember {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Actor/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(CastMemberRecord.self, from: data).fields
    }

    func getEventById(_ id: String) async throws -> CalendarEvent {
        let url = URL(string: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Calendar/\(id)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        var event = try decoder.decode(CalendarRecord.self, from: data).fields
        
        if let sID = event.serieID?.first {
            event.serie = try? await getSerieById(sID)
        }
        
        return event
    }
    
    // MARK: - FETCH LISTS
    
    func fetchLightSeries() async throws {
        isLoading = true
        defer { isLoading = false }
        
        let reqSeries = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Serie")
        let (dataSeries, _) = try await URLSession.shared.data(for: reqSeries)
        
        let decoder = JSONDecoder()
        let decodedSeries = try decoder.decode(SeriesResponse.self, from: dataSeries).records
        self.series = decodedSeries.map { $0.fields }
    }
    
    func fetchPlatforms() async throws {
        let req = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Platform")
        let (data, _) = try await URLSession.shared.data(for: req)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(PlatformsResponse.self, from: data).records

        self.allPlatforms = decoded.map { $0.fields }

        var mapping: [String: String] = [:]
        for record in decoded {
            mapping[record.id] = record.fields.name
        }
        self.platformIDToName = mapping
    }
    
    func fetchCalendarEvents() async throws {
        isLoading = true
        defer { isLoading = false }
        
        let req = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Calendar")
        let (data, _) = try await URLSession.shared.data(for: req)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let records = try decoder.decode(CalendarResponse.self, from: data).records
        
        var fetchedEvents: [CalendarEvent] = []
        for record in records {
            var event = record.fields
            if let sID = event.serieID?.first {
                event.serie = try? await getSerieById(sID)
            }
            fetchedEvents.append(event)
        }
        self.events = fetchedEvents.sorted(by: { $0.date < $1.date })
    }

    func fetchAllActors() async throws {
        let req = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Actor")
        let (data, _) = try await URLSession.shared.data(for: req)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let records = try decoder.decode(CastMemberResponse.self, from: data).records
        self.allActors = records.map { $0.fields }
    }

    func fetchSeries() async throws {
        isLoading = true
        defer { isLoading = false }
        
        let reqSeries = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Serie")
        let reqRoles = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/ActorSerie")
        let reqActors = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Actor")
        let reqReviews = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Reviews")
        let reqPlatforms = createRequest(urlStr: "https://api.airtable.com/v0/appIztQK14x6MyfL9/Platform")

        let (dataSeries, _) = try await URLSession.shared.data(for: reqSeries)
        let (dataRoles, _) = try await URLSession.shared.data(for: reqRoles)
        let (dataActors, _) = try await URLSession.shared.data(for: reqActors)
        let (dataReviews, _) = try await URLSession.shared.data(for: reqReviews)
        let (dataPlatforms, _) = try await URLSession.shared.data(for: reqPlatforms)

        let decoder = JSONDecoder()

        let decodedSeries = try decoder.decode(SeriesResponse.self, from: dataSeries).records
        let decodedRoles = try decoder.decode(ActorSeriesResponse.self, from: dataRoles).records
        let decodedActors = try decoder.decode(CastMemberResponse.self, from: dataActors).records
        let decodedReviews = try decoder.decode(ReviewResponse.self, from: dataReviews).records
        let decodedPlatforms = try decoder.decode(PlatformsResponse.self, from: dataPlatforms).records

        var dictActors: [String: CastMember] = [:]
        for record in decodedActors {
            dictActors[record.id] = record.fields
        }

        var dictRoles: [String: ActorSerie] = [:]
        for record in decodedRoles {
            var role = record.fields
            if let firstActorID = role.actorIDs?.first {
                role.actor = dictActors[firstActorID]
            }
            dictRoles[record.id] = role
        }
        
        var dictReviews: [String: ReviewItem] = [:]
        for record in decodedReviews {
            dictReviews[record.id] = record.fields
        }
        
        var dictPlatforms: [String: Platform] = [:]
        for record in decodedPlatforms {
            dictPlatforms[record.id] = record.fields
        }

        let finalSeries = decodedSeries.map { $0.fields }
        for serie in finalSeries {
            if let roleIDs = serie.actorIDs {
                serie.actors = roleIDs.compactMap { dictRoles[$0] }
            }
            if let revIDs = serie.reviewIDs {
                serie.reviews = revIDs.compactMap { dictReviews[$0] }
            }
            if let platIDs = serie.platformIDs {
                serie.platform = platIDs.compactMap { dictPlatforms[$0] }
            }
        }

        self.series = finalSeries
    }
}
