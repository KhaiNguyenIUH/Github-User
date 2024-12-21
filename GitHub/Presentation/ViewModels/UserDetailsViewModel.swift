import Foundation

final class UserDetailsViewModel: BaseViewModel {
    // MARK: - Published Properties
    @Published var userDetails: UserDetails?

    // MARK: - Dependencies
    private let userDetailsFetchingUseCase: UserDetailsFetchingUseCase

    // MARK: - Initializer
    init(userDetailsFetchingUseCase: UserDetailsFetchingUseCase) {
        self.userDetailsFetchingUseCase = userDetailsFetchingUseCase
    }

    // MARK: - Fetch User Details
    func fetchUserDetails(for username: String) {
        executeTask { [weak self] in
            guard let self else { return }

            let details = try await self.userDetailsFetchingUseCase.fetchUserDetails(username: username)
            await MainActor.run {
                self.userDetails = details
            }
        }
    }
}
