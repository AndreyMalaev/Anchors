//
//  HTMLDecoder.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/24/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import Foundation

class HTMLDecoder {
    
    static let HTMLSymbols = "<a href"
    
    static func removeHTMLfrom(inputString: String, withCompletion completion: @escaping(String) -> Void) {
        
        guard let data = inputString.data(using: .utf8) else {
            completion(inputString)
            return
        }
        
        if self.containHTML(inString: inputString) {
            
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [ .documentType: NSAttributedString.DocumentType.html,
                                                                                .characterEncoding: String.Encoding.utf8.rawValue ]
            
                let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
                    
                    if let outputString = attributedString?.string {
                        completion(outputString)
                    } else {
                        completion(inputString)
                    }
        } else {
            completion(inputString)
        }
    }
    
    static func containHTML(inString string: String) -> Bool {
        if string.range(of: self.HTMLSymbols) != nil {
            return true
        } else {
            return false
        }
    }
    
    init() {
        print("class HTMLDecoder is INIT")
    }
    
    deinit {
        print("class HTMLDecoder is DEINIT")
    }
}
