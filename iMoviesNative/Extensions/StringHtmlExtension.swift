//
//  StringHtmlExtension.swift
//  iMoviesNative
//
//  Created by MacBook on 4/14/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import Foundation

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func getUrlString(fromTag:String, ext: String)->String?{
        
        let str = self
        
        if let endRange = str.range(of: ext) , let startRange = str.range(of: fromTag) {
            let raw = str[startRange.upperBound..<endRange.upperBound]
            var result = ""
            result.append(raw.replacingOccurrences(of: "\\", with: ""))
            return String(result)
        }
        
        return nil
    }
}
