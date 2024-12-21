import Foundation
import Alamofire
@testable import GitHub

//class MockAPIClient: APIClient {
   
//}
class MockAPIClient: APIRequestable {
    var result: Result<Data, Error> = .success(Data())

    func get<T: Decodable>(endpoint: String) async throws -> T {
        switch result {
        case .success(let data):
            return try JSONDecoder().decode(T.self, from: data)
        case .failure(let error):
            throw error
        }
    }
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        switch result {
        case .success(let data):
            return try decoder.decode(T.self, from: data)
        case .failure(let error):
            throw error
        }
    }
}
