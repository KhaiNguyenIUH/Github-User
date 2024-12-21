import Foundation

struct User: Codable, Hashable {
    let id: UUID
    let login: String
    let avatarURL: String
    let htmlURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }

    // Custom Initializer (for generating a UUID if not decoded)
    init(login: String, avatarURL: String, htmlURL: String) {
        self.id = UUID() // Automatically generates a unique UUID
        self.login = login
        self.avatarURL = avatarURL
        self.htmlURL = htmlURL
    }

    // Custom Decodable Implementation
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = UUID() // Generate a UUID during decoding
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        self.htmlURL = try container.decode(String.self, forKey: .htmlURL)
    }

    // Custom Hashable Implementation
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)        // Unique identifier
        hasher.combine(login)     // Combine login for additional uniqueness
    }

    // Equatable Implementation
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
               lhs.login == rhs.login
    }
}
