//
//  ImageAuthorView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/14/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class ImageAuthorView: UIView {
    
    // MARK: - UI Properties
    var imageAuthorLabel: NewsTextLabel!
    var imageDescriptionLabel: NewsTextLabel!

    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lentachGray.withAlphaComponent(0.3)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupImageAuthorLabel()
        self.setupImageDescriptionLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageAuthorView {
    
    fileprivate func setupImageAuthorLabel() {
        
        self.imageAuthorLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 12, andTextColor: .white)
        self.imageAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.imageAuthorLabel)
        
        self.imageAuthorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.imageAuthorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.imageAuthorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.imageAuthorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func setupImageDescriptionLabel() {
        
        self.imageDescriptionLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 12, andTextColor: .white)
        self.imageDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.imageDescriptionLabel.isHidden = true
        
        self.addSubview(self.imageDescriptionLabel)
        
        self.imageDescriptionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageDescriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.imageDescriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.imageDescriptionLabel.bottomAnchor.constraint(equalTo: self.imageAuthorLabel.topAnchor).isActive = true
        
        self.imageDescriptionLabel.addObserver(self, forKeyPath: "text", options: [.new], context: nil)
    }
}

extension ImageAuthorView {
    
    override func observeValue(forKeyPath keyPath: String?,
                                        of object: Any?,
                                           change: [NSKeyValueChangeKey : Any]?,
                                          context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            self.updateConstraintsInSuperViews()
        }
    }
    
    fileprivate func updateConstraintsInSuperViews() {
        
        if let conteinerNewsView = self.superview(of: ConteinerNewsView.self) {
            
            conteinerNewsView.heightImageAuthorViewConstraint?.constant -= 20
        
            UIView.animate(withDuration: 1.0, animations: {
                conteinerNewsView.layoutIfNeeded()
            }) { [unowned self] _ in
                self.imageDescriptionLabel.isHidden = false
            }
        }
    }
}


