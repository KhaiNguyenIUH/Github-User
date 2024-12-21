import Foundation

struct UserDetails: Codable, Hashable {
    let id: UUID
    let login: String
    let avatarURL: String
    let htmlURL: String
    let location: String?
    let followers: Int
    let following: Int
    let blog: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case location, followers, following, blog
    }

    // Custom Initializer (for manual creation)
    init(login: String, avatarURL: String, htmlURL: String, location: String?, followers: Int, following: Int, blog: String?) {
        self.id = UUID() // Automatically generates a unique UUID
        self.login = login
        self.avatarURL = avatarURL
        self.htmlURL = htmlURL
        self.location = location
        self.followers = followers
        self.following = following
        self.blog = blog
    }

    // Custom Decodable Implementation
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = UUID() // Generate a UUID during decoding
        self.login = try container.decode(String.self, forKey: .login)
        self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        self.htmlURL = try container.decode(String.self, forKey: .htmlURL)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.following = try container.decode(Int.self, forKey: .following)
        self.blog = try container.decode(String.self, forKey: .blog)
    }

    // Custom Hashable Implementation
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)        // Unique identifier
        hasher.combine(login)     // Combine login for additional uniqueness
        hasher.combine(avatarURL) // Optional: Use additional properties if necessary
    }

    // Equatable Implementation
    static func == (lhs: UserDetails, rhs: UserDetails) -> Bool {
        return lhs.id == rhs.id &&
               lhs.login == rhs.login &&
               lhs.avatarURL == rhs.avatarURL &&
               lhs.htmlURL == rhs.htmlURL &&
               lhs.location == rhs.location &&
               lhs.followers == rhs.followers &&
               lhs.following == rhs.following
    }
}
