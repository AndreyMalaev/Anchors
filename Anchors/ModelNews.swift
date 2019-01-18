//
//  Model.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/14/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import Foundation

struct LentaAPINewsResponse: Decodable {
    
    let news: News?
    
    enum CodingKeys: String, CodingKey {
        case news = "topic"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.news = try container.decodeIfPresent(News.self, forKey: .news)
    }
}

struct News: Decodable {
    
    let newsInfo: NewsInfo?
    let contentBlocks: [ContentBlockTest]?
    let thematicNews: [ThematicNews]?
    
    enum CodingKeys: String, CodingKey {
        case newsInfo = "headline"
        case contentBlocks = "body"
        case thematicNews = "box_link"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.newsInfo = try container.decodeIfPresent(NewsInfo.self, forKey: .newsInfo)
        self.contentBlocks = try container.decodeIfPresent([ContentBlockTest].self, forKey: .contentBlocks)
        self.thematicNews = try container.decodeIfPresent([ThematicNews].self, forKey: .thematicNews)
    }
}

extension News {
    
    func newsTextContent() -> String? {
        
        guard let contentBlocks = self.contentBlocks else { return nil }
        
        var newsText = String.init()
        
        let numberOfParagraphs = self.numberOfContentBlocksInNews(withContentType: .paragraph)
        var numberOfIterations = 0
        
        let dispathGroup = DispatchGroup.init()
        
        for contentBlock in contentBlocks {
            
            if let content = contentBlock.contentData {
                switch content {
                case .text(let text):
                    dispathGroup.enter()
                        
                        HTMLDecoder.removeHTMLfrom(inputString: text, withCompletion: { string in
                            numberOfIterations += 1
                            
                            if numberOfIterations != numberOfParagraphs {
                                newsText += string + String.paragraphSeparator
                            } else {
                                newsText += string
                            }
                            
                            dispathGroup.leave()
                        })
                    
                    dispathGroup.wait()
                    
                case .mediaContent: break
                case .inlinetopic: break
                }
            }
        }
        return newsText
    }
    
    func numberOfContentBlocksInNews(withContentType contentType: ContentBlockType) -> Int {
        return self.contentBlocks?.filter{$0.contentType == contentType}.count ?? 0
    }
}

struct NewsInfo: Decodable {
    
    let info: Info?
    let newsImage: NewsImage?
    
    enum CodingKeys: String, CodingKey {
        case info
        case newsImage = "title_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.info = try container.decodeIfPresent(Info.self, forKey: .info)
        self.newsImage = try container.decodeIfPresent(NewsImage.self, forKey: .newsImage)
    }
}

struct Info: Decodable {
    
    let announce: String?
    
    enum CodingKeys: String, CodingKey {
        case announce
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.announce = try container.decodeIfPresent(String.self, forKey: .announce)
    }
}

struct NewsImage: Decodable {
    
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case description = "caption"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}

struct ContentBlock: Decodable {
    
    let type: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        
        if self.type == "p" {
            self.content = try container.decodeIfPresent(String.self, forKey: .content)
        } else {
            self.content = nil
        }
    }
}

// full test code

enum ContentBlockType: String, Decodable {
    case video = "eagleplatform"
    case paragraph = "p"
    case inlinetopic = "inlinetopic"
}

struct ContentBlockTest: Decodable {
    
    let contentType: ContentBlockType?
    let contentData: Content?
    
    enum CodingKeys: String, CodingKey {
        case contentType = "type"
        case contentData = "content"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.contentType = try container.decodeIfPresent(ContentBlockType.self, forKey: .contentType)
        self.contentData = try container.decodeIfPresent(Content.self, forKey: .contentData)
    }
}

// test struct

enum Content: Decodable {
    
    case mediaContent(MediaContent)
    case text(String)
    case inlinetopic([SingleLatestNews])
    /*
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .text(x)
            return
        }
        if let x = try? container.decode(MediaContent.self) {
            self = .mediaContent(x)
            return
        }
        throw DecodingError.typeMismatch(MediaContent.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ContentUnion"))
    }
    */
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .text(x)
            return
        } else if let x = try? container.decode(MediaContent.self) {
            self = .mediaContent(x)
            return
        } else if let x = try? container.decode([SingleLatestNews].self) {
            self = .inlinetopic(x)
            return
        }
        throw DecodingError.typeMismatch(MediaContent.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ContentUnion"))
    }
}

struct MediaContent: Decodable {
    
    let description: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case description
        case url = "watch_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}

//



// end test code

struct ThematicNews: Decodable {
    
    let type: String?
    let thematicNewsInfo: ThematicNewsInfo?
    let thematicNewsURLs: ThematicNewsURLs?
    let thematicNewsImage: ThematicNewsImage?
    
    enum CodingKeys: String, CodingKey {
        case type
        case thematicNewsInfo = "info"
        case thematicNewsURLs = "links"
        case thematicNewsImage = "title_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.thematicNewsInfo = try container.decodeIfPresent(ThematicNewsInfo.self, forKey: .thematicNewsInfo)
        self.thematicNewsURLs = try container.decodeIfPresent(ThematicNewsURLs.self, forKey: .thematicNewsURLs)
        self.thematicNewsImage = try container.decodeIfPresent(ThematicNewsImage.self, forKey: .thematicNewsImage)
    }
}

struct ThematicNewsInfo: Decodable {
    
    let title: String?
    let rightcol: String?
    let announce: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rightcol
        case announce
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.rightcol = try container.decodeIfPresent(String.self, forKey: .rightcol)
        self.announce = try container.decodeIfPresent(String.self, forKey: .announce)
    }
}

struct ThematicNewsURLs: Decodable {
    
    let api: String?
    let site: String?
    
    enum CodingKeys: String, CodingKey {
        case api = "self"
        case site = "public"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.api = try container.decodeIfPresent(String.self, forKey: .api)
        self.site = try container.decodeIfPresent(String.self, forKey: .site)
    }
}

struct ThematicNewsImage: Decodable {
    
    let author: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "credits"
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
