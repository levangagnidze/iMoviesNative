//
//  UIImageViewExtension.swift
//  iMoviesNative
//
//  Created by MacBook on 4/14/18.
//  Copyright © 2018 MacBook. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView {
    public func imageFromUrl(url: URL?) {
        
        guard let _ = url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                    
                }else {
                    print("no data")
                }
            }else{
                print(error ?? "Can't print error")
            }
        }
        task.resume()
    }
}
