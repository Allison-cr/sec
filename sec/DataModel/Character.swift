import Foundation

// MARK: - Location

struct Location: Decodable {
    
    // MARK: - Properties
    
    let name: String
    let url: String
}

// MARK: - CharacterResponse

struct CharacterResponse: Decodable {
    
    // MARK: - Properties
    
    let results: [Character]
}

// MARK: - Character

struct Character: Decodable {
    
    // MARK: - Properties
    
    /// The name of 'Character'
    let name: String
    
    /// The gender of 'Character'
    let gender: String
    
    /// The species of 'Character'
    let species: String
    
    /// The image of 'Character'
    let image: URL
    
    /// The status of 'Character'
    let status: String
    
    /// The type of 'Character'
    let type: String
    
    /// The origin of 'Character'
    let origin: Location
    
    /// An array of 'Character' episodes
    var episodes: [EpisodeData]

    enum CodingKeys: String, CodingKey {
        case name
        case gender
        case species
        case image
        case status
        case type
        case origin
        case episodesURLs = "episode"
    }
    
    // MARK: - Initializers
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        gender = try container.decode(String.self, forKey: .gender)
        species = try container.decode(String.self, forKey: .species)
        image = try container.decode(URL.self, forKey: .image)
        status = try container.decode(String.self, forKey: .status)
        type = try container.decode(String.self, forKey: .type)
        origin = try container.decode(Location.self, forKey: .origin)
        let episodesURLs = try container.decode([URL].self, forKey: .episodesURLs)
        episodes = []
        for episodeURL in episodesURLs {
            if let episodeData = try? Data(contentsOf: episodeURL) {
                if let episode = try? JSONDecoder().decode(EpisodeData.self, from: episodeData) {
                    episodes.append(episode)
                }
            }
        }
    }
}

// MARK: - EpisodeData

struct EpisodeData: Decodable, Hashable {
    
    // MARK: - Properties
    
    /// The name of 'Episode'
    let name: String
    
    /// The date  of 'Episode'
    let air_date: String
    
    /// The number  of 'Episode'
    let episode: String
}
