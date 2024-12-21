import Foundation

class MockUserRepository: UserRepository {
    private let mockUsers: [User] = [
        // Static list of mock users based on the provided JSON
        User(login: "jvantuyl", avatarURL: "https://avatars.githubusercontent.com/u/101?v=4", htmlURL: "https://github.com/jvantuyl"),
        User(login: "BrianTheCoder", avatarURL: "https://avatars.githubusercontent.com/u/102?v=4", htmlURL: "https://github.com/BrianTheCoder"),
        User(login: "freeformz", avatarURL: "https://avatars.githubusercontent.com/u/103?v=4", htmlURL: "https://github.com/freeformz"),
        User(login: "hassox", avatarURL: "https://avatars.githubusercontent.com/u/104?v=4", htmlURL: "https://github.com/hassox"),
        User(login: "automatthew", avatarURL: "https://avatars.githubusercontent.com/u/105?v=4", htmlURL: "https://github.com/automatthew"),
        User(login: "queso", avatarURL: "https://avatars.githubusercontent.com/u/106?v=4", htmlURL: "https://github.com/queso"),
        User(login: "lancecarlson", avatarURL: "https://avatars.githubusercontent.com/u/107?v=4", htmlURL: "https://github.com/lancecarlson"),
        User(login: "drnic", avatarURL: "https://avatars.githubusercontent.com/u/108?v=4", htmlURL: "https://github.com/drnic"),
        User(login: "lukesutton", avatarURL: "https://avatars.githubusercontent.com/u/109?v=4", htmlURL: "https://github.com/lukesutton"),
        User(login: "danwrong", avatarURL: "https://avatars.githubusercontent.com/u/110?v=4", htmlURL: "https://github.com/danwrong"),
        User(login: "HamptonMakes", avatarURL: "https://avatars.githubusercontent.com/u/111?v=4", htmlURL: "https://github.com/HamptonMakes"),
        User(login: "jfrost", avatarURL: "https://avatars.githubusercontent.com/u/112?v=4", htmlURL: "https://github.com/jfrost"),
        User(login: "mattetti", avatarURL: "https://avatars.githubusercontent.com/u/113?v=4", htmlURL: "https://github.com/mattetti"),
        User(login: "ctennis", avatarURL: "https://avatars.githubusercontent.com/u/114?v=4", htmlURL: "https://github.com/ctennis"),
        User(login: "lawrencepit", avatarURL: "https://avatars.githubusercontent.com/u/115?v=4", htmlURL: "https://github.com/lawrencepit"),
        User(login: "marcjeanson", avatarURL: "https://avatars.githubusercontent.com/u/116?v=4", htmlURL: "https://github.com/marcjeanson"),
        User(login: "grempe", avatarURL: "https://avatars.githubusercontent.com/u/117?v=4", htmlURL: "https://github.com/grempe"),
        User(login: "peterc", avatarURL: "https://avatars.githubusercontent.com/u/118?v=4", htmlURL: "https://github.com/peterc"),
        User(login: "ministrycentered", avatarURL: "https://avatars.githubusercontent.com/u/119?v=4", htmlURL: "https://github.com/ministrycentered"),
        User(login: "afarnham", avatarURL: "https://avatars.githubusercontent.com/u/120?v=4", htmlURL: "https://github.com/afarnham"),
        User(login: "jvantuyl", avatarURL: "https://avatars.githubusercontent.com/u/101?v=4", htmlURL: "https://github.com/jvantuyl"),
        User(login: "BrianTheCoder", avatarURL: "https://avatars.githubusercontent.com/u/102?v=4", htmlURL: "https://github.com/BrianTheCoder"),
        User(login: "freeformz", avatarURL: "https://avatars.githubusercontent.com/u/103?v=4", htmlURL: "https://github.com/freeformz"),
        User(login: "hassox", avatarURL: "https://avatars.githubusercontent.com/u/104?v=4", htmlURL: "https://github.com/hassox"),
        User(login: "automatthew", avatarURL: "https://avatars.githubusercontent.com/u/105?v=4", htmlURL: "https://github.com/automatthew"),
        User(login: "queso", avatarURL: "https://avatars.githubusercontent.com/u/106?v=4", htmlURL: "https://github.com/queso"),
        User(login: "lancecarlson", avatarURL: "https://avatars.githubusercontent.com/u/107?v=4", htmlURL: "https://github.com/lancecarlson"),
        User(login: "drnic", avatarURL: "https://avatars.githubusercontent.com/u/108?v=4", htmlURL: "https://github.com/drnic"),
        User(login: "lukesutton", avatarURL: "https://avatars.githubusercontent.com/u/109?v=4", htmlURL: "https://github.com/lukesutton"),
        User(login: "danwrong", avatarURL: "https://avatars.githubusercontent.com/u/110?v=4", htmlURL: "https://github.com/danwrong"),
        User(login: "HamptonMakes", avatarURL: "https://avatars.githubusercontent.com/u/111?v=4", htmlURL: "https://github.com/HamptonMakes"),
        User(login: "jfrost", avatarURL: "https://avatars.githubusercontent.com/u/112?v=4", htmlURL: "https://github.com/jfrost"),
        User(login: "mattetti", avatarURL: "https://avatars.githubusercontent.com/u/113?v=4", htmlURL: "https://github.com/mattetti"),
        User(login: "ctennis", avatarURL: "https://avatars.githubusercontent.com/u/114?v=4", htmlURL: "https://github.com/ctennis"),
        User(login: "lawrencepit", avatarURL: "https://avatars.githubusercontent.com/u/115?v=4", htmlURL: "https://github.com/lawrencepit"),
        User(login: "marcjeanson", avatarURL: "https://avatars.githubusercontent.com/u/116?v=4", htmlURL: "https://github.com/marcjeanson"),
        User(login: "grempe", avatarURL: "https://avatars.githubusercontent.com/u/117?v=4", htmlURL: "https://github.com/grempe"),
        User(login: "peterc", avatarURL: "https://avatars.githubusercontent.com/u/118?v=4", htmlURL: "https://github.com/peterc"),
        User(login: "ministrycentered", avatarURL: "https://avatars.githubusercontent.com/u/119?v=4", htmlURL: "https://github.com/ministrycentered"),
        User(login: "afarnham", avatarURL: "https://avatars.githubusercontent.com/u/120?v=4", htmlURL: "https://github.com/afarnham"),
        User(login: "jvantuyl", avatarURL: "https://avatars.githubusercontent.com/u/101?v=4", htmlURL: "https://github.com/jvantuyl"),
        User(login: "BrianTheCoder", avatarURL: "https://avatars.githubusercontent.com/u/102?v=4", htmlURL: "https://github.com/BrianTheCoder"),
        User(login: "freeformz", avatarURL: "https://avatars.githubusercontent.com/u/103?v=4", htmlURL: "https://github.com/freeformz"),
        User(login: "hassox", avatarURL: "https://avatars.githubusercontent.com/u/104?v=4", htmlURL: "https://github.com/hassox"),
        User(login: "automatthew", avatarURL: "https://avatars.githubusercontent.com/u/105?v=4", htmlURL: "https://github.com/automatthew"),
        User(login: "queso", avatarURL: "https://avatars.githubusercontent.com/u/106?v=4", htmlURL: "https://github.com/queso"),
        User(login: "lancecarlson", avatarURL: "https://avatars.githubusercontent.com/u/107?v=4", htmlURL: "https://github.com/lancecarlson"),
        User(login: "drnic", avatarURL: "https://avatars.githubusercontent.com/u/108?v=4", htmlURL: "https://github.com/drnic"),
        User(login: "lukesutton", avatarURL: "https://avatars.githubusercontent.com/u/109?v=4", htmlURL: "https://github.com/lukesutton"),
        User(login: "danwrong", avatarURL: "https://avatars.githubusercontent.com/u/110?v=4", htmlURL: "https://github.com/danwrong"),
        User(login: "HamptonMakes", avatarURL: "https://avatars.githubusercontent.com/u/111?v=4", htmlURL: "https://github.com/HamptonMakes"),
        User(login: "jfrost", avatarURL: "https://avatars.githubusercontent.com/u/112?v=4", htmlURL: "https://github.com/jfrost"),
        User(login: "mattetti", avatarURL: "https://avatars.githubusercontent.com/u/113?v=4", htmlURL: "https://github.com/mattetti"),
        User(login: "ctennis", avatarURL: "https://avatars.githubusercontent.com/u/114?v=4", htmlURL: "https://github.com/ctennis"),
        User(login: "lawrencepit", avatarURL: "https://avatars.githubusercontent.com/u/115?v=4", htmlURL: "https://github.com/lawrencepit"),
        User(login: "marcjeanson", avatarURL: "https://avatars.githubusercontent.com/u/116?v=4", htmlURL: "https://github.com/marcjeanson"),
        User(login: "grempe", avatarURL: "https://avatars.githubusercontent.com/u/117?v=4", htmlURL: "https://github.com/grempe"),
        User(login: "peterc", avatarURL: "https://avatars.githubusercontent.com/u/118?v=4", htmlURL: "https://github.com/peterc"),
        User(login: "ministrycentered", avatarURL: "https://avatars.githubusercontent.com/u/119?v=4", htmlURL: "https://github.com/ministrycentered"),
        User(login: "afarnham", avatarURL: "https://avatars.githubusercontent.com/u/120?v=4", htmlURL: "https://github.com/afarnham")
    ]
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        let startIndex = since
        let endIndex = min(startIndex + perPage, mockUsers.count)
        guard startIndex < endIndex else { return [] }
        return Array(mockUsers[startIndex..<endIndex])
    }
    
    func fetchUserDetails(username: String) async throws -> UserDetails {
        guard let user = mockUsers.first(where: { $0.login == username }) else {
            throw NSError(domain: "MockUserRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        
        // Create UserDetails using matching User and mock data
        return UserDetails(
            login: user.login,
            avatarURL: user.avatarURL,
            htmlURL: user.htmlURL,
            location: "Mock Location for \(user.login)",
            followers: 100 + 10 % 50, // Simulate different follower counts
            following: 10 + 2 % 20,
            blog: user.htmlURL  // Simulate different following counts
        )
    }
}
