//
//  PreviewNewsView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/27/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

final class NewsPreviewContentView: UIView {

    // MARK: - UI Properties
    private var newsImageView: NewsImageView!
    private var newsImageInfoView: InfoView!
    private var newsDateLabel: NewsTextLabel!
    private var newsTitleLabel: NewsTextLabel!
    private var newsTitleSeparator: UIView!
    private var newsAnnounceLabel: NewsTextLabel!
    
    // MARK: - Constraint Properties
    private var newsImageInfoViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: -
    private var isAuthorInfoViewExpanded = false
    
    // MARK: - Constants
    private struct NewsHeaderViewConstants {
        static let standardHeightImageInfoViewConstant: CGFloat = 20
        static let maximumHeightImageInfoViewConstant: CGFloat = 40
    }
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupNewsImageView()
        setupImageAuthorView()
        setupDateLabel()
        seputTitleLabel()
        setupTitleSeparator()
        setupAnnounceLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI Constraints
extension NewsPreviewContentView {
    
    fileprivate func setupNewsImageView() {
        
        self.newsImageView = NewsImageView.init(frame: CGRect.zero)
        self.addSubview(self.newsImageView)
        
        self.newsImageView.translatesAutoresizingMaskIntoConstraints = false
        self.newsImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.newsImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.newsImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.newsImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        // bottom anchor
        // self.newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func setupImageAuthorView() {
        
        self.newsImageInfoView = InfoView.init(frame: CGRect.zero)
        self.newsImageView.addSubview(self.newsImageInfoView)
        
        self.newsImageInfoView.translatesAutoresizingMaskIntoConstraints = false
        self.newsImageInfoView.leftAnchor.constraint(equalTo: self.newsImageView.leftAnchor).isActive = true
        self.newsImageInfoView.rightAnchor.constraint(equalTo: self.newsImageView.rightAnchor).isActive = true
        self.newsImageInfoView.bottomAnchor.constraint(equalTo: self.newsImageView.bottomAnchor).isActive = true
        
        self.newsImageInfoViewHeightConstraint = self.newsImageInfoView.heightAnchor.constraint(equalToConstant: NewsHeaderViewConstants.standardHeightImageInfoViewConstant)
        self.newsImageInfoViewHeightConstraint?.isActive = true
    }
    
    fileprivate func setupDateLabel() {
        
        self.newsDateLabel = NewsTextLabel.init(frame: CGRect.zero, fontSize: 12)
        self.addSubview(self.newsDateLabel)
        
        self.newsDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsDateLabel.topAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: +20).isActive = true
        self.newsDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func seputTitleLabel() {
        
        self.newsTitleLabel = NewsTextLabel.init(frame: CGRect.zero, fontSize: 25)
        self.addSubview(self.newsTitleLabel)
        
        self.newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsTitleLabel.topAnchor.constraint(equalTo: self.newsDateLabel.bottomAnchor, constant: +10).isActive = true
        self.newsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func setupTitleSeparator() {
        
        self.newsTitleSeparator = UIView.init(frame: CGRect.zero)
        self.newsTitleSeparator.backgroundColor = .lentachGray
        self.newsTitleSeparator.alpha = 0.5
        self.addSubview(self.newsTitleSeparator)
        
        self.newsTitleSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.newsTitleSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.newsTitleSeparator.topAnchor.constraint(equalTo: self.newsTitleLabel.bottomAnchor, constant: +10).isActive = true
        self.newsTitleSeparator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTitleSeparator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
    }
    
    fileprivate func setupAnnounceLabel() {
        
        self.newsAnnounceLabel = NewsTextLabel.init(frame: CGRect.zero, fontSize: 18)
        self.addSubview(self.newsAnnounceLabel)
        
        self.newsAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsAnnounceLabel.topAnchor.constraint(equalTo: self.newsTitleSeparator.bottomAnchor,
                                                   constant: +10).isActive = true
        self.newsAnnounceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsAnnounceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.newsAnnounceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}

// MARK: - Setup Data In UI
extension NewsPreviewContentView {

    func setImageDescription(_ text: String?) {
        let shouldExpandImageInfoView = (text != nil) ? true : false
        
        updateImageInfoViewHeightConstraint(shouldExpandImageInfoView) { [weak self] in
            self?.newsImageInfoView.setDescription(text)
        }
    }
    
    func configure(_ viewModel: NewsPreviewContentViewModel) {
        self.newsImageView.image = viewModel.image
        self.newsImageInfoView.setAuthor(viewModel.imageAuthor)
        self.newsDateLabel.text = viewModel.date
        self.newsTitleLabel.text = viewModel.title
        self.newsAnnounceLabel.text = viewModel.announce
            
        self.layoutIfNeeded()
    }
}

// MARK: - Animate Update UI Constraints
extension NewsPreviewContentView {
    
    private func updateImageInfoViewHeightConstraint(_ shouldExpand: Bool, complete: @escaping () -> Void) {
        
        if !self.isAuthorInfoViewExpanded {
            if shouldExpand {
                self.newsImageInfoViewHeightConstraint?.constant = NewsHeaderViewConstants.maximumHeightImageInfoViewConstant
                self.isAuthorInfoViewExpanded = true
                
                UIView.animate(withDuration: 1.0, animations: {
                    self.layoutIfNeeded()
                }) { _ in
                    complete()
                }
            }
        } else {
            complete()
        }
    }
}
