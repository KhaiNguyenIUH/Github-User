import XCTest
@testable import GitHub

class UserDetailsViewModelTests: XCTestCase {
    var viewModel: UserDetailsViewModel!
    var mockUseCase: MockUserDetailsFetchingUseCase!

    override func setUpWithError() throws {
        mockUseCase = MockUserDetailsFetchingUseCase()
        viewModel = UserDetailsViewModel(userDetailsFetchingUseCase: mockUseCase)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockUseCase = nil
    }

    func testFetchUserDetails_Success() async throws {
        // Arrange
        let mockDetails = UserDetails(
            login: "testUser",
            avatarURL: "https://example.com/avatar.png", 
            htmlURL: "https://example.com/avatar.png",
            location: "Test Location",
            followers: 100,
            following: 50,
            blog: "https://example.com/blog"
        )
        mockUseCase.mockResult = .success(mockDetails)

        // Act
        viewModel.fetchUserDetails(for: "testUser")
        try await Task.sleep(nanoseconds: 500_000_000) // Wait for async task

        // Assert
        XCTAssertNotNil(viewModel.userDetails)
        XCTAssertEqual(viewModel.userDetails?.login, mockDetails.login)
        XCTAssertEqual(viewModel.userDetails?.followers, mockDetails.followers)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchUserDetails_Failure() async throws {
        // Arrange
        mockUseCase.mockResult = .failure(NSError(domain: "TestError", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))

        // Act
        viewModel.fetchUserDetails(for: "testUser")
        try await Task.sleep(nanoseconds: 500_000_000) // Wait for async task

        // Assert
        XCTAssertNil(viewModel.userDetails) // Should remain nil
        XCTAssertNotNil(viewModel.errorMessage) // Error message must not be nil
        XCTAssertEqual(viewModel.errorMessage, "User not found")
        XCTAssertFalse(viewModel.isLoading) // isLoading must be false
    }
}

// Mock UserDetailsFetchingUseCase
class MockUserDetailsFetchingUseCase: UserDetailsFetchingUseCase {
    var mockResult: Result<UserDetails, Error> = .failure(NSError(domain: "TestError", code: 404, userInfo: nil))
    
    func fetchUserDetails(username: String) async throws -> UserDetails {
        switch mockResult {
        case .success(let details):
            return details
        case .failure(let error):
            throw error
        }
    }
}
