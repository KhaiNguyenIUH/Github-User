import Foundation

final class UsersViewModel: BaseViewModel {
    // MARK: - Published Properties
    @Published var users: [User] = []
    @Published var hasMoreUsers = true

    // MARK: - Private Properties
    private let userFetchingUseCase: UserFetchingUseCase
    private var currentPage = 0
    private let itemsPerPage = 20
    private var isCacheLoaded = false

    // MARK: - Initializer
    init(userFetchingUseCase: UserFetchingUseCase) {
        self.userFetchingUseCase = userFetchingUseCase
        super.init()
        loadCachedUsers()
    }

    // MARK: - Public Methods

    func loadUsers(reset: Bool = false) {
        guard !isLoading && hasMoreUsers else { return }

        if reset {
            users.removeAll()
            currentPage = 0
        }

        executeTask { [weak self] in
            guard let self else { return }

            let fetchedUsers = try await self.userFetchingUseCase.fetchUsers(
                perPage: self.itemsPerPage,
                since: self.currentPage * self.itemsPerPage
            )

            await MainActor.run {
                if fetchedUsers.isEmpty {
                    self.hasMoreUsers = false
                } else {
                    self.users.append(contentsOf: fetchedUsers)
                    self.currentPage += 1
                }
            }

            self.cacheUsers(fetchedUsers)
        }
    }

    func clearCache() {
        UserCache.shared.clearCache()
    }

    // MARK: - Private Methods

    private func loadCachedUsers() {
        guard !isCacheLoaded else { return }
        isCacheLoaded = true

        if let cachedUsers = UserCache.shared.loadUsers(), !cachedUsers.isEmpty {
            users = cachedUsers
            currentPage = cachedUsers.count / itemsPerPage
        } else {
            loadUsers()
        }
    }

    private func cacheUsers(_ newUsers: [User]) {
        var existingUsers = UserCache.shared.loadUsers() ?? []

        for newUser in newUsers where !existingUsers.contains(where: { $0.id == newUser.id }) {
            existingUsers.append(newUser)
        }

        UserCache.shared.saveUsers(existingUsers)
    }
}
