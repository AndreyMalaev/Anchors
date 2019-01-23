//
//  ImageAuthorView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/14/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

final class InfoView: UIView {
    
    // MARK: - UI Properties
    private var authorLabel: NewsTextLabel!
    private var descriptionLabel: NewsTextLabel!

    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lentachGray.withAlphaComponent(0.1)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupAuthorLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoView {
    
    fileprivate func setupAuthorLabel() {
        
        self.authorLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 12, andTextColor: .white)
        
        self.addSubview(self.authorLabel)
        
        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.authorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func setupDescriptionLabel() {
        
        self.descriptionLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 12, andTextColor: .white)
        self.descriptionLabel.isHidden = true
        
        self.addSubview(self.descriptionLabel)

        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.authorLabel.topAnchor).isActive = true
    }
}

extension InfoView {
    
    func setAuthor(_ text: String?) {
        
        guard let author = text else {
            self.authorLabel.text = "no author"
            return
        }
        
        if HTMLDecoder.containHTML(inString: author) {
            HTMLDecoder.removeHTMLfrom(inputString: author) { [weak self] outputString in
                self?.authorLabel.text = outputString
            }
        } else {
            self.authorLabel.text = author
        }
    }
    
    func setDescription(_ text: String?) {
        
        if self.descriptionLabel == nil {
            setupDescriptionLabel()
        }
        
        self.descriptionLabel.text = text
        self.descriptionLabel.isHidden = false
    }
}


