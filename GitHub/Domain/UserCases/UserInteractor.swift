class UserInteractor: UserFetchingUseCase, UserDetailsFetchingUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        return try await repository.fetchUsers(perPage: perPage, since: since)
    }

    func fetchUserDetails(username: String) async throws -> UserDetails {
        return try await repository.fetchUserDetails(username: username)
    }
}
