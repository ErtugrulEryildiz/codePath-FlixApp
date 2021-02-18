//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Ertugrul Eryildiz on 2/18/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    var movie: [String: Any]!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Movie Title and Description
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        descriptionLabel.text = movie["overview"] as? String
        descriptionLabel.sizeToFit()
        
        // Get the image poster URL
        let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
        let poster_path = movie["poster_path"] as! String
        let posterUrl = URL(string: posterBaseUrl + poster_path)
        // Set Image poster
        posterView.af_setImage(withURL: posterUrl!)
        
        // Get the image poster URL
        let backdropBaseUrl = "https://image.tmdb.org/t/p/w780"
        let backdrop_path = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: backdropBaseUrl + backdrop_path)
        // Set Image poster
        backdropView.af_setImage(withURL: backdropUrl!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
