//
//  Movie.swift
//  iMoviesNative
//
//  Created by MacBook on 4/13/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import Foundation

struct Movie : Codable, CustomStringConvertible {
    
    let url : URL?
    let id : Int
    let value : String?
    let year : Int?
    let primaryDescription : String?
    let secondaryDescription : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case value = "primaryName"
        case url = "poster"
        case year
        case primaryDescription
        case secondaryDescription
    }
    
    var details: String? {
        if let desc = secondaryDescription , desc.count > 0 {
           return secondaryDescription
        }
        return primaryDescription
    }
    
    var imageURL: URL? {
        get{
            return url
        }
    }
    
    var description: String {
        return " \(value ?? "") \(String(describing: details))"
    }
}
