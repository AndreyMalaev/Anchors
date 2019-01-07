//
//  work.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/16/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import Foundation
/*
// full test code

enum ContentBlockType: String, Decodable {
    case video = "eagleplatform"
    case paragraph = "p"
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

// end test code
*/
