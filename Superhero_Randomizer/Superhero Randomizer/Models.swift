import Foundation

struct Hero: Decodable {
    let id: Int
    let name: String
    let slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work?
    let connections: Connections?
    let images: Images
}

struct Powerstats: Decodable {
    let intelligence: Int?
    let strength: Int?
    let speed: Int?
    let durability: Int?
    let power: Int?
    let combat: Int?
}

struct Appearance: Decodable {
    let gender: String?
    let race: String?
    let height: [String]? // [imperial, metric]
    let weight: [String]? // [imperial, metric]
}

struct Biography: Decodable {
    let fullName: String?
    let alterEgos: String?
    let placeOfBirth: String?
    let firstAppearance: String?
    let publisher: String?
    let alignment: String?
}

struct Work: Decodable { let occupation: String?; let base: String? }
struct Connections: Decodable { let groupAffiliation: String?; let relatives: String? }


struct Images: Decodable { let xs: URL; let sm: URL; let md: URL; let lg: URL }
