import Foundation

// MARK: - Response Data
struct Cards: Codable {
    let data: [Card]
}

struct CardDetails: Codable {
    let data: Card
}

// MARK: - Card
struct Card: Codable {
    let id: String
    let name: String
    let hp: String
    let supertype: String
    
    let subtypes: [String]
    let types: [String]
    
    let images: Images?
    let flavorText: String?

    enum CodingKeys: String, CodingKey {
        case id, name, flavorText, hp, supertype, images
        case types, subtypes
    }
}

struct Images: Codable {
    let small, large: String
}
