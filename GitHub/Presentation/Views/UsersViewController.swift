import UIKit
import SnapKit
import Combine

class UsersViewController: BaseViewController<UsersViewModel>, ShakeClearable {
    // MARK: - Dependencies
    private let shakeHandler: ShakeHandler
    
    // MARK: - UI Components
    private var dataSource: UITableViewDiffableDataSource<Int, User>!
    private let tableView = UITableView()
    private let emptyStateView = EmptyStateView()


    // MARK: - Initializer
    override init(viewModel: UsersViewModel) {
        self.shakeHandler = ShakeHandler(delegate: nil)
        super.init(viewModel: viewModel)
        
        self.shakeHandler.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitHub Users"
        
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTableView()
        setupEmptyStateView()
        setupDataSource()
        bindViewModel()
    }
    
    // MARK: - Shake Motion Handling
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        shakeHandler.handleMotionBegan(motion)
    }
    
    // MARK: - Clear Cache
    func clearCache() {
        viewModel.clearCache()
    }

    // MARK: - UI Setup
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.showsVerticalScrollIndicator = false

        tableView.delegate = self
    }
    
    private func setupEmptyStateView() {
        view.addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyStateView.isHidden = true
        
        // Retry action handler
        emptyStateView.actionHandler = { [weak self] in
            self?.viewModel.loadUsers()
        }
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, User>(tableView: tableView) { tableView, indexPath, user in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
                fatalError("Unable to dequeue UserTableViewCell")
            }
            cell.configure(with: user)
            return cell
        }
    }
    
    // MARK: - ViewModel Binding
    override func bindViewModel() {
        viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.applySnapshot(users: users)
                self?.emptyStateView.isHidden = !users.isEmpty
                self?.emptyStateView.configure(message: "No users found", showButton: true)
            }
            .store(in: &cancellables)
    }

    // MARK: - Helpers
    private func applySnapshot(users: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, User>()
        
        // Create a section for each user
        for (index, user) in users.enumerated() {
            snapshot.appendSections([index])
            snapshot.appendItems([user], toSection: index)
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else { return }

        // Navigate to UserDetailsViewController
        let apiClient = APIClient(baseURL: Config.baseURL)
        let userDetailsFetchingUseCase = UserInteractor(repository: GitHubService(apiClient: apiClient))
        let viewModel = UserDetailsViewModel(userDetailsFetchingUseCase: userDetailsFetchingUseCase)
        let detailsVC = UserDetailsViewController(username: user.login, viewModel: viewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        // Only call `loadUsers` if more users are available
        if offsetY > contentHeight - scrollView.frame.height {
            if viewModel.hasMoreUsers {
                viewModel.loadUsers()
            } 
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Return an empty transparent view as the "spacer"
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
}
