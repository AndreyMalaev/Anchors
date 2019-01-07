//
//  NewsViewController.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/11/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var news: SingleLatestNews?
    var newsContent: LentaAPINewsResponse? {
        didSet {
            print("newsContent sucsses loaded")
            // self.configureContentViews()
        }
    }
    
    let tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init()
        activityIndicator.settingWithStyle(style: .white, andColor: UIColor.lentachGray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // view controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print input news
        print(news ?? "luuul")
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden(value: true)
        
        // setup table view
        self.setupTableViewAnchors()
        self.setupTableViewProtocols()
        
        // setup activity indicator
        self.setupActivityIndicatorAnchors()
        
        //
        self.setupContentNewsView()
        
        // news request
        self.requestNews1()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            // return navigation bar to default state
            self.navigationController?.navigationBar.isHidden(value: false)
            self.navigationController?.view.backgroundColor = .purple
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // setup color scroll indicator in table view
        self.tableView.setScrollIndicatorColor(color: UIColor.lentachGray)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let headerView = tableView.tableHeaderView {
            
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
}

// MARK: - extensions for setup ui controller
// MARK: - extensions for setup table view
extension NewsViewController {
    
    func setupTableViewProtocols() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupTableViewAnchors() {
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

// MARK: - extension for setup activity indicator
extension NewsViewController {
    
    func setupActivityIndicatorAnchors() {
        
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func setupContentNewsView() {
        
        let contentNewsView = ContentNewsView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        
        //self.tableView.customSetTableHeaderView(headerView: contentNewsView)
        
        self.tableView.tableHeaderView = contentNewsView
        
        guard let imageStringURL = self.news?.image?.url else { return }
        
        Network.loadImage(fromStringURL: imageStringURL) { [weak self] loadedImage in
            
            if let image = loadedImage {
                DispatchQueue.main.async {
                    if let header = self?.tableView.tableHeaderView as? ContentNewsView {
                        header.newsImageView.setWithAnimation(image: image)
                    }
                    
                    if let author = self?.news?.image?.author {
                        if let header = self?.tableView.tableHeaderView as? ContentNewsView {
                            header.newsImageAuthorLabel.text = author
                        }
                    }
                    self?.viewDidLayoutSubviews()
                }
            }
        }
    }
}

// MARK: - Extensions for table view protocols
// MARK: - Extension for table view delegate
extension NewsViewController: UITableViewDelegate {
    
}

// MARK: - Extension for table view data source
extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.newsContent != nil ? 2 : 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsContent != nil ? 3 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.textLabel?.text = "section: \(indexPath.section), row: \(indexPath.row)"
        cell.backgroundColor = .purple
        return cell
    }
}

// MARK: - extension for update content views after load news detail content

extension NewsViewController {
    
    func configureContentViews() {
        
        guard let text = self.newsContent?.news?.newsTextContent() else { return }
        
        HTMLDecoder.removeHTMLfrom(inputString: text) { textWithoutHTML in
            print(textWithoutHTML)
            
            if let date = self.news?.info?.date {
                if let header = self.tableView.tableHeaderView as? ContentNewsView {
                    header.newsDateLabel.text = DateManager.createStringDate(withSecondsIntervalSince1970: date)
                    header.newsDateLabel.updateLabelFrame()
                    header.sizeToFit()
                    // self.tableView.updateHeightHeaderView()
                }
            }
            
            if let title = self.news?.info?.title {
                if let header = self.tableView.tableHeaderView as? ContentNewsView {
                    header.newsTitleLabel.text = title
                    header.newsTitleLabel.updateLabelFrame()
                    header.sizeToFit()
                    // self.tableView.updateHeightHeaderView()
                }
            }
            
            if let header = self.tableView.tableHeaderView as? ContentNewsView {
                header.newsTextLabel.text = textWithoutHTML
                header.newsTextLabel.updateLabelFrame()
                header.sizeToFit()
                // self.tableView.updateHeightHeaderView()
            }
            
            
            self.tableView.updateHeightHeaderView()
            self.tableView.reloadData()
            
            
            guard let header = self.tableView.tableHeaderView as? ContentNewsView else { return }
            
            let height1 = header.bounds.height
            print("current height - \(height1)")
            let height2 = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            print("layout height - \(height2)")
            
            print(header.newsImageView.frame)
            print(header.newsImageAuthorLabel.frame)
            print(header.newsDateLabel.frame)
            print(header.newsTitleLabel.frame)
            print(header.newsTextLabel.frame)
            
            let heightAllObject = header.newsImageView.frame.height + header.newsDateLabel.frame.height + header.newsTitleLabel.frame.height + header.newsTextLabel.frame.height
            print("height all object - \(heightAllObject)")
            
            
            let heightCells = 6 * 44
            // let totalHeight = Int(height2) + heightCells
            let totalHeight = Int(heightAllObject) + heightCells
            
            print("contentsize before update - \(self.tableView.contentSize)")
            
            self.tableView.contentSize = CGSize.init(width: Int(self.tableView.frame.width), height: totalHeight)
            
            print("contentsize after update - \(self.tableView.contentSize)")
            
            
            self.tableView.tableHeaderView?.sizeToFit()
        }
    }
    
}

// MARK: - extension for network request
extension NewsViewController {
    
    func requestNews1() {
        
        guard let stringURL = self.news?.URLs?.api else { return }
        guard let newsURL = URL.init(string: stringURL) else { return }
        
        NewsManager.requestNews(fromURL: newsURL) { [weak self] newsContent in
            self?.newsContent = newsContent
        }
    }
    
    /*
    func requestNews() {
        
        guard let stringURL = self.news?.URLs?.api else { return }
        guard let newsURL = URL.init(string: stringURL) else { return }
        
        NewsManager.requestNews(fromURL: newsURL) { response in
            // print(response ?? "kek")
            
            
            
            if let contentBlocks = response?.news?.contentBlocks {
                for contentBlock in contentBlocks {
                    print("content type: \(contentBlock.contentType?.rawValue ?? "no content type")")
                    
                    if let contentType = contentBlock.contentType {
                        print(contentType)
                    }
                    
                    if let content = contentBlock.contentData {
                        switch content {
                        case .mediaContent(let media):
                            print(media)
                        case .text(let text):
                            print(text)
                        case .inlinetopic(let topic):
                            print(topic)
                        }
                    }
                }
            }
            
            print("ANNOUNCE")
            print("news announce: \(response?.news?.newsInfo?.info?.announce ?? "no announce")")
            
            /*
            if let thematicNews = response?.news?.thematicNews {
                for news in thematicNews {
                    print("news type: \(news.type ?? "no news type")")
                    print("***")
                    print("thematic news info")
                    print("news announce: \(news.thematicNewsInfo?.announce ?? "no news announce")")
                    print("news rightcol: \(news.thematicNewsInfo?.rightcol ?? "no news rightcol")")
                    print("news title: \(news.thematicNewsInfo?.title ?? "no news title")")
                    print("***")
                    print("thematic news urls")
                    print("news api: \(news.thematicNewsURLs?.api ?? "no news api")")
                    print("news site: \(news.thematicNewsURLs?.site ?? "no news site")")
                    print("***")
                    print("thematic news image")
                    print("news author: \(news.thematicNewsImage?.author ?? "no news author")")
                    print("news url: \(news.thematicNewsImage?.url ?? "no news url")")
                }
            }
            */
        }
    }
    */
}

// MARK: - extensions for any types
// MARK: - extension for hide or show navigation bar
extension UINavigationBar {
    
    func isHidden(value: Bool) {
        switch value {
        case true:
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            self.isTranslucent = true
        case false:
            self.setBackgroundImage(nil, for: .default)
            self.shadowImage = nil
            self.isTranslucent = false
        }
    }
}
