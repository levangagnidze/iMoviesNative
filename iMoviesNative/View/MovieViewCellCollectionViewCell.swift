//
//  MovieViewCellCollectionViewCell.swift
//  iMoviesNative
//
//  Created by MacBook on 4/14/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit

class MovieViewCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var alertView: UIView!
    
    var movie : Movie? = nil
    
    let animationDuration = 0.2
    
    let focusSize = CGSize(width: 250, height: 250)
    let defaultSize = CGSize(width: 200, height: 200)
    let focusedColor = UIColor.white
    let defaultColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(movie:Movie){
        
        
        self.movie = movie
        
        self.movieImage.layer.cornerRadius = 10
        self.movieImage.clipsToBounds = true
        
        self.alertView.layer.cornerRadius = 25
        self.alertView.isHidden = true
        
        label.text = movie.value
        movieImage.imageFromUrl(url:movie.imageURL)
        
        setDefaultStyle()
    }
    
    func setDefaultStyle(){
        UIView.animate(withDuration: animationDuration, animations: {
            self.movieImage.frame.size = self.defaultSize
            self.label.textColor = self.defaultColor
            self.label.isHidden = true
        })
        hideAlert()
    }
    
    func setHighlightStyle(){
        UIView.animate(withDuration: animationDuration, animations: {
            self.movieImage.frame.size = self.focusSize
            self.label.textColor = self.focusedColor
            self.label.isHidden = false
        })
    }
    
    func showAlert(){
        alertView.isHidden = false
    }
    
    func hideAlert(){
        alertView.isHidden = true
    }
}
