//
//  EmptyStateView.swift
//  GitUser
//
//  Created by Dev on 15/12/24.
//


import UIKit
import SnapKit

class EmptyStateView: UIView {
    private let messageLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    
    // Callback for the action button
    var actionHandler: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Configure message label
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addSubview(messageLabel)
        
        // Configure action button
        actionButton.setTitle("Retry", for: .normal)
        actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func handleAction() {
        actionHandler?()
    }
    
    // Public API to update the view
    func configure(message: String, showButton: Bool = true) {
        messageLabel.text = message
        actionButton.isHidden = !showButton
    }
}
