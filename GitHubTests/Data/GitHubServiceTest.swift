import XCTest
@testable import GitHub

class GitHubServiceTests: XCTestCase {
    var service: GitHubService!
    var mockAPIClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        service = GitHubService(apiClient: mockAPIClient)
    }

    override func tearDown() {
        mockAPIClient = nil
        service = nil
        super.tearDown()
    }

    func testFetchUsers_Success() async throws {
        // Arrange
        let mockUsersData = """
        [{
            "login": "testUser",
            "avatar_url": "https://example.com/avatar.png",
            "html_url": "https://example.com"
        }]
        """.data(using: .utf8)!
        mockAPIClient.result = .success(mockUsersData)

        // Act
        let users = try await service.fetchUsers(perPage: 20, since: 0)
        print("Fetched Users: \(users)")

        // Assert
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.login, "testUser")
    }

    func testFetchUsers_Failure() async throws {
        // Arrange
        mockAPIClient.result = .failure(NSError(domain: "TestError", code: 404))

        // Act & Assert
        do {
            let _ = try await service.fetchUsers(perPage: 20, since: 0)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
