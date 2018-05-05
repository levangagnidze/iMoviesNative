//
//  iMoviesService.swift
//  iMoviesNative
//
//  Created by MacBook on 4/13/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import Foundation
import Alamofire

class iMoviesService {
    
    static let baseURL = "https://api.imovies.cc/api/v1/"
    
    static func searchMovies(text:String, completionHandler:@escaping (_ store:MovieStore,_ error:String?) -> ())
    {
        let newText = text.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        var URL = "\(baseURL)search?filters[type]=movie&page=1&per_page=30&keywords=\(newText)"
        
        URL = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if let value = response.result.value as? [String:Any] {
                
                var store : MovieStore
                store = MovieStore()
                
                if let movies = value["data"] as? [Any] {
                    
                    for json in movies {
                        if let movie = Movie.covertJsonToModel(json: json) {
                            store.movies.append(movie)
                        }
                    }
                    if store.movies.count > 0 {
                        completionHandler(store, nil)
                        
                    }else{
                        completionHandler(store, "Could not parse response")
                    }
                }
            }
        }
    }
    
    static func loadMovieLanguages(movieId:String, completionHandler:@escaping (_ movieFiles:[MovieFile]?,_ error:String?) -> ())
    {
        
        var URL = "\(baseURL)movies/\(movieId)/season-files/"
        
        URL = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            var movieFiles : [MovieFile]?
            
            if let value = response.result.value as? [String:Any] {
                if let data = value["data"] as? [Any], data.count > 0 {
                    if let firstData = data[0] as? [String:Any] {
                        if let files = firstData["files"] as? [Any] {
                        movieFiles = []
                        
                        for currFile in files {
                            if let file = currFile as? [String:Any]{
                                
                                guard let langValue = file["lang"] as? String else{
                                    continue
                                }
                                
                                if let files = file["files"] as? [Any]
                                    {
                                        for currFile in files {
                                            if let _currFile = currFile as? [String:Any]{
                                                
                                                var dict = _currFile
                                                
                                                //add language key value
                                                dict[MovieFile.CodingKeys.language.rawValue] = langValue
                                               
                                                //create final model
                                                if let movieFile = MovieFile.covertJsonToModel(json: dict)  {
                                                    movieFiles?.append(movieFile)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            completionHandler(movieFiles,"Error:While invoking files service")
        }
    }
}

