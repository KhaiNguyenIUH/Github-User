import Foundation
import Combine

class BaseViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Methods
    
    /// Executes an async task safely with loading and error handling.
    func executeTask(
        _ task: @escaping () async throws -> Void,
        onError: @escaping (String) -> Void = { _ in }
    ) {
        isLoading = true
        Task { [weak self] in
            guard let self else { return }
            defer { self.isLoading = false } // Reset loading state

            do {
                try await task()
            } catch {
                await MainActor.run {
                    let errorMessage = (error as NSError).userInfo[NSLocalizedDescriptionKey] as? String
                        ?? "An unknown error occurred."
                    self.errorMessage = errorMessage
                    onError(errorMessage)
                }
            }
        }
    }
}
