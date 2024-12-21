import Alamofire

protocol APIRequestable {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        decoder: JSONDecoder
    ) async throws -> T
    
    func get<T: Decodable>(endpoint: String) async throws -> T
}

class APIClient: APIRequestable {
    private let session: Session
    private let baseURL: String
    
    init(baseURL: String, session: Session = .default) {
        self.baseURL = baseURL
        self.session = session
    }
    
    // MARK: - GET Convenience Method
    func get<T: Decodable>(endpoint: String) async throws -> T {
        return try await request(endpoint: endpoint, method: .get, parameters: nil, headers: nil)
    }
    
    // MARK: - REQUEST Convenience Method
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {        
        // Construct the full URL
        let url = "\(baseURL)\(endpoint)"
        
        // Convert headers dictionary to Alamofire's HTTPHeaders
        let allHeaders = HTTPHeaders(headers ?? [:])
        
#if DEBUG
        // Log the request
        logRequest(url: url, method: method, parameters: parameters, headers: headers)
#endif

        // Make the network request
        let request = session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
            headers: allHeaders
        )
        
        // Await response and decode
        do {
            let response = await request.serializingDecodable(T.self, decoder: decoder).response
            
#if DEBUG
            // Log the response
            logResponse(response: response)
#endif
            
            // Check HTTP status code
            guard let statusCode = response.response?.statusCode, (200..<300).contains(statusCode) else {
                throw APIError.invalidResponse(statusCode: response.response?.statusCode)
            }
            
            // Return the decoded result
            return try response.result.get()
        } catch {
            // Log error
            print("Error occurred: \(error.localizedDescription)")
            throw handleError(error)
        }
    }
    
    // MARK: - Logging
    
    private func logRequest(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: [String: String]?) {
        print("➡️ Request:")
        print("URL: \(url)")
        print("Method: \(method.rawValue)")
        if let parameters = parameters {
            print("Parameters: \(parameters)")
        }
        if let headers = headers {
            print("Headers: \(headers)")
        }
    }
    
    private func logResponse<T>(response: DataResponse<T, AFError>) {
        print("⬅️ Response:")
        if let statusCode = response.response?.statusCode {
            print("Status Code: \(statusCode)")
        }
        if let data = response.data, let body = String(data: data, encoding: .utf8) {
            print("Body: \(body)")
        }
    }
    
    // Error handling
    private func handleError(_ error: Error) -> APIError {
        if let afError = error as? AFError {
            switch afError {
            case .sessionTaskFailed(let underlyingError as NSError):
                if underlyingError.code == NSURLErrorNetworkConnectionLost {
                    return .networkError("The network connection was lost. Please try again.")
                }
                return .networkError(underlyingError.localizedDescription)
            case .responseSerializationFailed:
                return .decodingError
            default:
                return .unknownError(afError.localizedDescription)
            }
        }
        
        return .unknownError(error.localizedDescription)
    }
}

enum APIError: Error {
    case invalidResponse(statusCode: Int?) // Handles non-200 HTTP status codes
    case decodingError                    // Handles JSON decoding issues
    case networkError(String)             // Handles network connectivity issues
    case unknownError(String)             // Handles all other errors
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse(let statusCode):
            return "Invalid response from server. Status code: \(statusCode ?? -1)"
        case .decodingError:
            return "Failed to decode the response from the server."
        case .networkError(let message):
            return "Network error: \(message)"
        case .unknownError(let message):
            return "Unknown error: \(message)"
        }
    }
}
