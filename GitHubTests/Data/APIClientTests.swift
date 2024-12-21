import XCTest
import Alamofire
@testable import GitHub

class APIClientTests: XCTestCase {
    var apiClient: APIClient!

    override func setUp() {
        super.setUp()
                
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self] // Use MockURLProtocol
        let session = Session(configuration: config)

        apiClient = APIClient(baseURL: "https://api.github.com", session: session)
    }

    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }

    func testSuccessfulResponse() async throws {
        // Arrange
        let expectedData = """
        [{
            "login": "testUser",
            "avatar_url": "https://example.com/avatar.png",
            "html_url": "https://example.com"
        }]
        """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            print("Intercepted Request: \(request.url!)")
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, expectedData)
        }

        // Act
        let result: [User] = try await apiClient.get(endpoint: "/users")

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].login, "testUser")
        XCTAssertEqual(result[0].avatarURL, "https://example.com/avatar.png")
        XCTAssertEqual(result[0].htmlURL, "https://example.com")
    }

    func testErrorResponse() async throws {
        // Arrange
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://api.github.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // Act & Assert
        do {
            let _: [User] = try await apiClient.get(endpoint: "/users")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
