//
//  ViewController.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/11/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let view1: UIView = {
        let view = UIView.init()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let view2: UIView = {
        let view = UIView.init()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.setupView1()
        // self.setupView2()
    }
    
    fileprivate func setupView1() {
        self.view.addSubview(self.view1)
        
        self.view1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.view1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.view1.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.view1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        print(self.navigationController?.navigationBar.frame.maxY ?? "no navbar maxY")
        print(self.view1.frame.minY)
    }
    
    fileprivate func setupView2() {
        self.view1.addSubview(self.view2)
        
        self.view2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        self.view2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.view2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.view2.heightAnchor.constraint(equalTo: self.view1.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    @IBAction func openNextViewController(_ sender: Any) {
        let nextViewController = NewsViewController()
        nextViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

