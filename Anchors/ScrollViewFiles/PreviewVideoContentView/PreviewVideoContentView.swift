//
//  VideoContentNewsView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/28/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

protocol PreviewVideoContentViewDelegate: class {
    
    func previewVideoContentViewDidTapPlay(_ previewVideoContentView: PreviewVideoContentView)
}

class PreviewVideoContentView: UIView {
    
    // MARK: - Delegate
    weak var delegate: PreviewVideoContentViewDelegate?
    
    // MARK: - UI Properties
    private var previewImageView: NewsImageView!
    private var alphaView: UIView!
    private var playButton: UIButton!
    private var descriptionLabel: NewsTextLabel!
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isHidden = true
        self.backgroundColor = .lentachGray
        self.isUserInteractionEnabled = true
        
        setupPreviewImageView()
        setupAlphaView()
        setupPlayButton()
        setupDescriptionLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI Constraints
extension PreviewVideoContentView {
    
    private func setupPreviewImageView() {
        
        self.previewImageView = NewsImageView.init(frame: CGRect.zero)
        self.previewImageView.isUserInteractionEnabled = true
        
        self.addSubview(self.previewImageView)
        
        self.previewImageView.translatesAutoresizingMaskIntoConstraints = false
        self.previewImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.previewImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.previewImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.previewImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func setupAlphaView() {
        
        self.alphaView = UIView.init(frame: self.previewImageView.frame)
        self.alphaView.backgroundColor = .lentachGray
        self.alphaView.alpha = 0.3
        
        self.alphaView.isUserInteractionEnabled = true
        
        self.previewImageView.addSubview(self.alphaView)
        
        self.alphaView.translatesAutoresizingMaskIntoConstraints = false
        self.alphaView.topAnchor.constraint(equalTo: self.previewImageView.topAnchor).isActive = true
        self.alphaView.leftAnchor.constraint(equalTo: self.previewImageView.leftAnchor).isActive = true
        self.alphaView.rightAnchor.constraint(equalTo: self.previewImageView.rightAnchor).isActive = true
        self.alphaView.bottomAnchor.constraint(equalTo: self.previewImageView.bottomAnchor).isActive = true
    }
    
    private func setupPlayButton() {
        
        self.playButton = UIButton.init(type: .custom)
        self.playButton.frame = CGRect.zero
        
        self.playButton.isUserInteractionEnabled = true
        
        let playImage = UIImage.init(named: "play.png")
        self.playButton.setImage(playImage, for: .normal)
        self.playButton.setImage(playImage, for: .selected)
        
        self.playButton.addTarget(self, action: #selector(PreviewVideoContentView.tapOnPlayButton), for: .touchUpInside)
        
        self.previewImageView.addSubview(self.playButton)
        
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.playButton.centerXAnchor.constraint(equalTo: self.previewImageView.centerXAnchor).isActive = true
        self.playButton.centerYAnchor.constraint(equalTo: self.previewImageView.centerYAnchor).isActive = true
    }
    
    private func setupDescriptionLabel() {
        
        self.descriptionLabel = NewsTextLabel.init(frame: CGRect.zero, fontSize: 12, textColor: .white)
        
        self.addSubview(self.descriptionLabel)
        
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.topAnchor.constraint(equalTo: self.previewImageView.bottomAnchor, constant: +10).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

// MARK: - UI Actions
extension PreviewVideoContentView {
    
    @objc private func tapOnPlayButton() {
        print("tap on play button")
        self.delegate?.previewVideoContentViewDidTapPlay(self)
    }
}

// MARK: - Setup Data in UI
extension PreviewVideoContentView {
    
    func setPreviewImage(_ image: UIImage?) {
        self.previewImageView.image = image
    }
    
    func setDescription(_ text: String?) {
        self.descriptionLabel.text = text
    }
    
    func configure(_ viewModel: PreviewVideoContentViewModel) {
        setPreviewImage(viewModel.previewImage)
        setDescription(viewModel.description)
        self.isHidden = false
        self.layoutIfNeeded()
    }
}

