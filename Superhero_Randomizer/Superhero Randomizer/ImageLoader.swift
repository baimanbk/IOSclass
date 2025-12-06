import UIKit


final class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()


    func load(_ url: URL) async throws -> UIImage {
        if let cached = cache.object(forKey: url as NSURL) { return cached }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw APIError.invalidResponse
        }
        guard let image = UIImage(data: data) else {
            throw APIError.decodingFailed(NSError(domain: "image", code: -1))
        }
        cache.setObject(image, forKey: url as NSURL)
        return image
    }
}
