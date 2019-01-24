//
//  ContainerNewsView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/8/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

final class NewsHeaderView: UIView {
    
    // MARK: - Delegate
    weak var delegate: NewsHeaderViewDelegate?
    
    // MARK: - UI Properties
    private var newsImageView: NewsImageView!
    private var newsImageInfoView: InfoView!
    private var newsDateLabel: NewsTextLabel!
    private var newsTitleLabel: NewsTextLabel!
    private var titleSeparator: UIView!
    private var newsAnnounceLabel: NewsTextLabel!
    private var newsTextLabel: NewsTextLabel!
    private var textSeparator: UIView!
    // private var newsVideoPreviewImageView: UIImageView!
    private var previewImageView: PreviewVideoView!
    
    // MARK: - Constraint Properties
    private var newsImageInfoViewHeightConstraint: NSLayoutConstraint?
    private var textSeparartorBottomConstraints: NSLayoutConstraint?
    
    // test
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
        seputTitleNewsLabel()
        setupTitleSeparator()
        setupAnnounceLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI Constraints
extension NewsHeaderView {
    
    fileprivate func setupNewsImageView() {
        
        self.newsImageView = NewsImageView.init(frame: CGRect.zero)
        
        self.addSubview(self.newsImageView)
        
        self.newsImageView.translatesAutoresizingMaskIntoConstraints = false
        self.newsImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: +0).isActive = true
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
        
        self.newsDateLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 12)
        
        self.addSubview(self.newsDateLabel)
        
        self.newsDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsDateLabel.topAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: +20).isActive = true
        self.newsDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func seputTitleNewsLabel() {
        
        self.newsTitleLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 25)
        
        self.addSubview(self.newsTitleLabel)
        
        self.newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsTitleLabel.topAnchor.constraint(equalTo: self.newsDateLabel.bottomAnchor, constant: +10).isActive = true
        self.newsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func setupTitleSeparator() {
        
        self.titleSeparator = UIView.init(frame: CGRect.zero)
        self.titleSeparator.backgroundColor = .lentachGray
        self.titleSeparator.alpha = 0.3
        self.addSubview(self.titleSeparator)
        
        self.titleSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.titleSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.titleSeparator.topAnchor.constraint(equalTo: self.newsTitleLabel.bottomAnchor, constant: +10).isActive = true
        self.titleSeparator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.titleSeparator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
    }
    
    fileprivate func setupAnnounceLabel() {
        
        self.newsAnnounceLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 18)
        self.addSubview(self.newsAnnounceLabel)
        
        self.newsAnnounceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsAnnounceLabel.topAnchor.constraint(equalTo: self.titleSeparator.bottomAnchor, constant: +10).isActive = true
        self.newsAnnounceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsAnnounceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
    }
    
    fileprivate func setupNewsTextLabel() {
        
        self.newsTextLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 18)
        self.addSubview(self.newsTextLabel)
        
        self.newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsTextLabel.topAnchor.constraint(equalTo: self.newsAnnounceLabel.bottomAnchor, constant: +10).isActive = true
        self.newsTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        setupTextSeparator()
    }
    
    fileprivate func setupTextSeparator() {
        
        self.titleSeparator = UIView.init(frame: CGRect.zero)
        self.titleSeparator.backgroundColor = .lentachGray
        self.titleSeparator.alpha = 0.3
        self.addSubview(self.titleSeparator)
        
        self.titleSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.titleSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.titleSeparator.topAnchor.constraint(equalTo: self.newsTextLabel.bottomAnchor, constant: +20).isActive = true
        self.titleSeparator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.titleSeparator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.titleSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        self.textSeparartorBottomConstraints = self.titleSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                                          constant: -20)
        self.textSeparartorBottomConstraints?.isActive = true
    }
    
    /*
    fileprivate func setupNewsVideoPreviewImageView() {
        
        self.textSeparartorBottomConstraints?.isActive = false
        
        self.newsVideoPreviewImageView = UIImageView.init(frame: CGRect.zero)
        self.addSubview(self.newsVideoPreviewImageView)
        
        self.newsVideoPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        self.newsVideoPreviewImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.newsVideoPreviewImageView.topAnchor.constraint(equalTo: self.titleSeparator.bottomAnchor, constant: +20).isActive = true
        self.newsVideoPreviewImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsVideoPreviewImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.newsVideoPreviewImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        self.newsVideoPreviewImageView.layoutIfNeeded()
    }
    */
    
    private func setupPreviewImageViewWithDelegate(_ delegate: UIViewController?) {
        
        self.textSeparartorBottomConstraints?.isActive = false
        
        self.previewImageView = PreviewVideoView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 200))
        self.previewImageView.delegate = delegate as? PreviewVideoViewDelegate
        
        self.addSubview(self.previewImageView)
        
        self.previewImageView.translatesAutoresizingMaskIntoConstraints = false
        self.previewImageView.topAnchor.constraint(equalTo: self.titleSeparator.bottomAnchor, constant: +20).isActive = true
        self.previewImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.previewImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.previewImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        self.previewImageView.layoutIfNeeded()
        
    }
}

// MARK: - Setup Data In UI
extension NewsHeaderView {
    
    func setNewsImage(_ image: UIImage?) {
        self.newsImageView.image = image
    }
    
    func setImageAuthor(_ text: String?) {
        self.newsImageInfoView.setAuthor(text)
    }
    
    func setImageDescription(_ text: String?) {
        let shouldExpandImageInfoView = (text != nil) ? true : false
        
        updateImageInfoViewHeightConstraint(shouldExpandImageInfoView) { [weak self] in
            self?.newsImageInfoView.setDescription(text)
        }
    }
    
    func setDateNews(_ text: String?) {
        self.newsDateLabel.text = text
    }
    
    func setTitleNews(_ text: String?) {
        self.newsTitleLabel.text = text
    }
    
    func setAnnounceNews(_ text: String?) {
        self.newsAnnounceLabel.text = text
    }
    
    func setTextNews(_ text: String?) {
        if self.newsTextLabel == nil {
            setupNewsTextLabel()
        }
        self.newsTextLabel.text = text
    }
    
    func setPreviewImage(_ image: UIImage?, withDelegateForVideoPlayer delegate: UIViewController?) {
        if self.previewImageView == nil {
            setupPreviewImageViewWithDelegate(delegate)
        }
        self.previewImageView.setPreviewImage(image)
    }
    
    func setPreviewImageDescription(_ text: String?, withDelegateForVideoPlayer delegate: UIViewController?) {
        if self.previewImageView == nil {
            setupPreviewImageViewWithDelegate(delegate)
        }
        self.previewImageView.setDescription(text)
    }
}

// MARK: - Animate Update UI Constraints
extension NewsHeaderView {
    
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

// MARK: - Add Gesture Recognizer To Video Preview Image View
extension NewsHeaderView {
    /*
    func setupTapGestureRecognizerToNewsVideoPreviewImageView() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapOnVideoContent))
        self.newsVideoPreviewImageView.addGestureRecognizer(tap)
        self.newsVideoPreviewImageView.isUserInteractionEnabled = true
    }
    
    @objc func tapOnVideoContent() {
        print("go play video")
        self.delegate?.tapOnVideoContentInNewsHeaderView(self)
    }
    */
}

// MARK: - NewsHeaderViewDelegate
protocol NewsHeaderViewDelegate: class {
    func tapOnVideoContentInNewsHeaderView(_ newsHeaderView: NewsHeaderView)
}
