import Foundation

struct HeroEntity: Decodable {
    let id: Int
    let name: String
    let appearance: Appearance
    let images: HeroImage
    let biography: Biography
    let powerstats: powerstats
    let work: Work
    
    struct Work: Decodable {
        let occupation: String?
        let base: String?
    }
    
    var heroImageUrl: URL? {
        URL(string: images.sm)
    }

    struct Appearance: Decodable {
        let race: String?
    }

    struct HeroImage: Decodable {
        let sm: String
        let md: String
    }
    
    struct Biography: Decodable {
        let fullName: String?
        let placeOfBirth: String?
        let alignment: String?
        let publisher: String?
    }
    
    struct powerstats: Decodable {
        let intelligence: Int?
        let strength: Int?
        let speed: Int?
        let durability: Int?
        let power: Int?
        let combat: Int?
    }
}

