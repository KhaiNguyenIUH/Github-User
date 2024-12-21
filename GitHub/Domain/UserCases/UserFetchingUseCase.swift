protocol UserFetchingUseCase {
    func fetchUsers(perPage: Int, since: Int) async throws -> [User]
}
