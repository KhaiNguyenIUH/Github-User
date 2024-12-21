import UIKit
import SnapKit

class StatView: UIView {
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0) // Light gray background
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black // Icon color
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializer
    init(iconName: String, title: String) {
        super.init(frame: .zero)
        iconImageView.image = UIImage(systemName: iconName)
        titleLabel.text = title
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(iconImageView)
        addSubview(countLabel)
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.size.equalTo(24)
        }

        countLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Public Update Method
    func update(count: Int, type: StatType) {
        switch type {
        case .followers:
            countLabel.text = count > 100 ? "100+" : "\(count)"
        case .following:
            countLabel.text = count > 10 ? "10+" : "\(count)"
        }
    }
}

// MARK: - StatType Enum
enum StatType {
    case followers
    case following
}
