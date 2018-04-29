//
//  MovieViewController.swift
//  iMoviesNative
//
//  Created by MacBook on 4/27/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import UIKit
import AVKit

class MovieViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let tableViewCellIndetifier = "cell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView : UITableView!
    
    var movie : Movie!
    var movieFiles : [MovieFile]!
    var time : CMTime?
    
    var player : AVPlayer!
    
    let playerSegueIndetifier = "player"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIndetifier)
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        titleLabel.text = movie.value
        detailsLabel.text = movie.details
        imageView.imageFromUrl(url: movie.imageURL!)
        detailsLabel.sizeToFit()
    }

    func config(movie:Movie,movieFiles:[MovieFile],_ time:CMTime? = nil)->Void{
        self.movie = movie
        self.movieFiles = movieFiles
        self.time = time
        self.movieFiles.sort{
            ($0.language.rawValue, $0.quality.rawValue) <
            ($1.language.rawValue, $1.quality.rawValue)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _player = player {
            time = _player.currentTime()
            _player.replaceCurrentItem(with: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movieFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIndetifier) {
        
            let movieFile = movieFiles[indexPath.row]
            cell.textLabel?.text = "\(movieFile.language.rawValue) \(movieFile.quality.rawValue)"
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playMovieByUrl(url: movieFiles[indexPath.row].src)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playMovieByUrl(url:URL){
        performSegue(withIdentifier: playerSegueIndetifier, sender: url)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == playerSegueIndetifier
        {
            if let playerViewController = segue.destination as? AVPlayerViewController {
                
                if let url = sender as? URL {
                    player = AVPlayer(url: url)
                    playerViewController.player = player
                    if let seekPos = time {
                        playerViewController.player?.seek(to: seekPos)
                    }
                    playerViewController.player?.play()
                }
            }
        }
    }
 

}
