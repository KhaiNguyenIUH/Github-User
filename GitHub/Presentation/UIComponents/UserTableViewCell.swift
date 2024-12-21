import UIKit
import SnapKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 44
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
        
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.image = nil // Reset the image
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(separatorLine)
        containerView.addSubview(urlLabel)
        
        clipsToBounds = false
        containerView.clipsToBounds = false
        
        setupConstraints()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(88)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.top.equalTo(avatarImageView.snp.top)
            make.right.equalToSuperview().offset(-16)
        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
        
        urlLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.top.equalTo(separatorLine.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Configure Cell
    func configure(with user: User) {
        nameLabel.text = user.login
        urlLabel.text = user.htmlURL
                
        // Load image asynchronously
        if let url = URL(string: user.avatarURL) {
            avatarImageView.kf.setImage(
                with: url,
                options: [
                    .scaleFactor(UIScreen.main.scale),    // Adjust image scale
                    .transition(.fade(0.2)),              // Smooth fade-in transition
                    .cacheOriginalImage,
                    .memoryCacheExpiration(.seconds(30)) // Keep in memory for 5 minutes
                ]
            )
        }
    }
}
