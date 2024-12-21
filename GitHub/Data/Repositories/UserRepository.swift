protocol UserRepository {
    func fetchUsers(perPage: Int, since: Int) async throws -> [User]
    func fetchUserDetails(username: String) async throws -> UserDetails
}

