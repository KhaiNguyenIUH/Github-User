import UIKit
import SnapKit
import Combine
import Kingfisher

class UserDetailsViewController: BaseViewController<UserDetailsViewModel> {
    // MARK: - Dependencies
    private let username: String
    
    // MARK: - UI Components
    private let userCardView = UserCardView()
    private let followersView = StatView(iconName: "person.2.fill", title: "Followers")
    private let followingView = StatView(iconName: "person.fill", title: "Following")
    
    private lazy var blogTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Blog"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var blogLinkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Initializer
    init(username: String, viewModel: UserDetailsViewModel) {
        self.username = username
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        bindViewModel()
        viewModel.fetchUserDetails(for: username)
    }
    
    // MARK: - Setup View
    override func setupView() {
        super.setupView()
        
        title = "Users Detail"
        
        view.addSubview(userCardView)
        view.addSubview(followersView)
        view.addSubview(followingView)
        view.addSubview(blogTitleLabel)
        view.addSubview(blogLinkLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        userCardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        followersView.snp.makeConstraints { make in
            make.top.equalTo(userCardView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.width.equalTo(80)
        }
        
        followingView.snp.makeConstraints { make in
            make.top.equalTo(userCardView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-50)
            make.width.equalTo(80)
        }
        
        blogTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(followersView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        blogLinkLabel.snp.makeConstraints { make in
            make.top.equalTo(blogTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - ViewModel Binding
    override func bindViewModel() {
        viewModel.$userDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userDetails in
                guard let self = self, let userDetails = userDetails else { return }
                self.updateUI(with: userDetails)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(with userDetails: UserDetails) {
        userCardView.configure(
            avatarURL: userDetails.avatarURL,
            name: userDetails.login,
            location: userDetails.location
        )
        followersView.update(count: userDetails.followers, type: .followers)
        followingView.update(count: userDetails.following, type: .following)
        blogLinkLabel.text = userDetails.blog ?? "N/A"
    }
}
