import Foundation

enum Environment {
    case development
    case staging
    case production
}

struct Config {
    // Current environment
    static let environment: Environment = .production

    // Base URL
    static var baseURL: String {
        switch environment {
        case .development:
            return "https://dev-api.github.com"
        case .staging:
            return "https://staging-api.github.com"
        case .production:
            return "https://api.github.com"
        }
    }

    // Headers (Reusable for requests)
    struct Headers {
        static func defaultHeaders() -> [String: String] {
            return [
                "Content-Type": "application/json;charset=utf-8",
                "Accept": "application/json;charset=utf-8"
            ]
        }

        static func authenticatedHeaders(token: String) -> [String: String] {
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json;charset=utf-8",
                "Accept": "application/json;charset=utf-8"
            ]
        }
    }
}
