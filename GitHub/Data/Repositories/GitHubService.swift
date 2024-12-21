import Alamofire

class GitHubService: UserRepository {
    private let apiClient: APIRequestable
    
    init(apiClient: APIRequestable) {
        self.apiClient = apiClient
    }
    
    /// Fetches a list of users
    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        let parameters: [String: Any] = ["per_page": perPage, "since": since]
        return try await apiClient.request(
            endpoint: Endpoints.users,
            method: .get,
            parameters: parameters,
            headers: Config.Headers.defaultHeaders(),
            decoder: JSONDecoder()
        )
    }
    
    /// Fetches details for a specific user
    func fetchUserDetails(username: String) async throws -> UserDetails {
        return try await apiClient.request(
            endpoint: Endpoints.userDetails(username: username),
            method: .get,
            parameters: nil,
            headers: Config.Headers.defaultHeaders(),
            decoder: JSONDecoder()
        )
    }
    
    // MARK: - Endpoints
    private struct Endpoints {
        static let users = "/users"
        
        static func userDetails(username: String) -> String {
            return "/users/\(username)"
        }
    }
}
