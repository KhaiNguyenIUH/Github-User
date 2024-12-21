import XCTest
@testable import GitHub

class UsersViewModelTests: XCTestCase {
    var viewModel: UsersViewModel!
    var mockUseCase: MockUserFetchingUseCase!

    override func setUpWithError() throws {
        mockUseCase = MockUserFetchingUseCase()
        viewModel = UsersViewModel(userFetchingUseCase: mockUseCase)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockUseCase = nil
    }

    func testLoadUsers_Success() async throws {
        // Arrange
        let mockUser = User(login: "testUser", avatarURL: "https://example.com/avatar.png", htmlURL: "https://example.com")
        let mockUsers = Array(repeating: mockUser, count: 2) // Expected count: 2
        mockUseCase.mockResult = .success(mockUsers)

        // Act
        viewModel.loadUsers(reset: true) // Pass reset flag
        try await Task.sleep(nanoseconds: 500_000_000) // Wait for async task

        // Assert
        XCTAssertEqual(viewModel.users.count, mockUsers.count)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadUsers_Failure() async throws {
        // Arrange
        mockUseCase.mockResult = .failure(NSError(domain: "TestError", code: 0))

        // Act
        viewModel.loadUsers(reset: true) // Pass reset flag
        try await Task.sleep(nanoseconds: 500_000_000) // Wait for async task

        // Assert
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.users.count, 0)
        XCTAssertFalse(viewModel.isLoading)
    }
}

// Mock UserFetchingUseCase
class MockUserFetchingUseCase: UserFetchingUseCase {
    var mockResult: Result<[User], Error> = .success([])

    func fetchUsers(perPage: Int, since: Int) async throws -> [User] {
        switch mockResult {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
}
