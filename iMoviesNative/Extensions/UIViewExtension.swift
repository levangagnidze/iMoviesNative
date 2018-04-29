//
//  UIViewExtension.swift
//  iMoviesNative
//
//  Created by MacBook on 4/15/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(){
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
    }
}
