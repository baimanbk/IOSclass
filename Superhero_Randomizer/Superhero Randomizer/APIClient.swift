import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case emptyDataset

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .requestFailed(let e): return "Network error: \(e.localizedDescription)"
        case .invalidResponse: return "Invalid server response."
        case .decodingFailed(let e): return "Failed to parse data: \(e.localizedDescription)"
        case .emptyDataset: return "No heroes found in dataset."
        }
    }
}

final class SuperheroAPI {
    static let shared = SuperheroAPI()
    private init() {}

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        return URLSession(configuration: config)
    }()

    private var cachedHeroes: [Hero]? = nil

    func fetchAllHeroes() async throws -> [Hero] {
        if let heroes = cachedHeroes { return heroes }
        guard let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json") else { throw APIError.invalidURL }
        do {
            let (data, response) = try await session.data(from: url)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else { throw APIError.invalidResponse }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let heroes = try decoder.decode([Hero].self, from: data)
            guard !heroes.isEmpty else { throw APIError.emptyDataset }
            cachedHeroes = heroes
            return heroes
        } catch let e as APIError {
            throw e
        } catch {
// Attempt to distinguish networking vs decoding
            if (error as? URLError) != nil { throw APIError.requestFailed(error) }
            throw APIError.decodingFailed(error)
        }
    }

    func randomHero() async throws -> Hero {
        let list = try await fetchAllHeroes()
        return list.randomElement()!
    }
}
