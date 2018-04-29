//
//  MovieFile.swift
//  iMoviesNative
//
//  Created by MacBook on 4/27/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import Foundation

struct MovieFile : Codable{

    let src : URL
    let quality : MovieQuality
    let id : Int?
    let language : MovieLanguage
    
    enum CodingKeys: String, CodingKey {
        case id
        case quality = "quality"
        case src = "src"
        case language
    }
}

enum MovieLanguage : String, Codable {
    case geo = "GEO"
    case eng = "ENG"
    case rus = "RUS"
}

enum MovieQuality : String, Codable{
    case high = "HIGH"
    case medium = "MEDIUM"
}
