//
//  DecodableExtension.swift
//  iMoviesNative
//
//  Created by MacBook on 4/28/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import Foundation

extension Decodable{
    
 static func covertJsonToModel(json:Any)->Self?{
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            
            let jsonDecoder = JSONDecoder()
            
            let model = try jsonDecoder.decode(Self.self, from: data!)
            return model
            
        }catch{
            print("error \(error.localizedDescription) for JSON:\(json as? [String:Any] ??  ["":""])")
            return nil
        }
    }
}
