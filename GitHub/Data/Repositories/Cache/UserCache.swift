import Foundation

class UserCache {
    static let shared = UserCache()

    private let userCache = CacheManager<[User]>(fileName: "cachedUsers.json")
    private let userDetailsCache = CacheManager<UserDetails>(fileName: "cachedUserDetails.json")

    private init() {}

    // Save Users
    func saveUsers(_ users: [User]) {
        userCache.save(users)
    }

    // Load Users
    func loadUsers() -> [User]? {
        return userCache.load()
    }

    // Save User Details
    func saveUserDetails(_ details: UserDetails) {
        userDetailsCache.save(details)
    }

    // Load User Details
    func loadUserDetails() -> UserDetails? {
        return userDetailsCache.load()
    }
    
    // Clear
    func clearCache() {
        userCache.clearCache()
        userDetailsCache.clearCache()
    }
}
