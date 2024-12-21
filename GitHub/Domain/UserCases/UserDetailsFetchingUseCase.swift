protocol UserDetailsFetchingUseCase {
    func fetchUserDetails(username: String) async throws -> UserDetails
}
