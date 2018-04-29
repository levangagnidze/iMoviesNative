//
//  ViewController.swift
//  iMoviesNative
//
//  Created by MacBook on 4/13/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate {

    let detailsSegueIndetifier = "details"
    
    var store = MovieStore()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var searchText: UITextField!
    @IBAction func searchBtn(_ sender: Any) {
        search()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchText.delegate = self
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == searchText {
            search()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == detailsSegueIndetifier
        {
            if let movieViewController = segue.destination as? MovieViewController {
                
                if let _sender = sender as? (movie:Movie,movieFiles:[MovieFile]) {
                    movieViewController.config(movie: _sender.movie,movieFiles: _sender.movieFiles)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCellCollectionViewCell", for: indexPath) as? MovieViewCellCollectionViewCell {
            
            let movie = store.movies[indexPath.row]
            cell.config(movie: movie)
            
            if cell.gestureRecognizers?.count == nil {
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
                tap.allowedPressTypes = [NSNumber(value:UIPressType.select.rawValue)]
                cell.addGestureRecognizer(tap)
            }
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    @objc func tapped(gesture:UIGestureRecognizer){
        if let cell = gesture.view  as? MovieViewCellCollectionViewCell {
            print(cell.label.text ?? "")
            
            if let movie = cell.movie {
                
                showMovieDetails(movie: movie, cell: cell)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.movies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let prev = context.previouslyFocusedView as? MovieViewCellCollectionViewCell {
            prev.setDefaultStyle()
        }
        if let next = context.nextFocusedView as? MovieViewCellCollectionViewCell {
            next.setHighlightStyle()
            detailsLabel.text = next.movie?.details
        }else{
            detailsLabel.text = ""
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:400, height: 400)
    }
    
    func showMovieDetails(movie:Movie,cell:MovieViewCellCollectionViewCell){
        
        iMoviesService.loadMovieLanguages(movieId: String(movie.id), completionHandler: { (movieFiles , error) in
            
            if let _movieFiles = movieFiles {
                
                self.performSegue(withIdentifier: self.detailsSegueIndetifier, sender: (movie:cell.movie,movieFiles:movieFiles))
                let _ = _movieFiles.map{
                    print($0.src)
                    print($0.language)
                }
            }else{
                cell.showAlert()
            }
        })
    }
    
    func search(){
        
        guard let text = searchText.text, text.count > 0 else{
            return
        }
        
        store.movies.removeAll()
        iMoviesService.searchMovies(text: text, completionHandler: { (movieStore,error) in
            if let error = error {
                print(error)
            }else{
                self.store = movieStore
                self.collectionView.reloadData()
            }
        }
        )
    }
}

