//
//  MoviesViewController.swift
//  Flix
//
//  Created by Ertugrul Eryildiz on 2/4/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var TableView: UITableView!
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view
            
        TableView.dataSource = self
        TableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            
            self.movies = dataDictionary["results"] as! [[String: Any]]
            self.TableView.reloadData()
            
           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let descr = movie["overview"] as! String
        
        let poster_path = movie["poster_path"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterUrl = URL(string: baseUrl + poster_path)
        
        
        cell.titleLabel!.text = title
        cell.descriptionLabel!.text = descr
        
        cell.posterView.af_setImage(withURL: posterUrl!)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using seque.destionation.
        // Pass the selected object to the new view controller.
            
        let cell = sender as! UITableViewCell
        let indexPath = TableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let movieDetailsViewController = segue.destination as! MovieDetailsViewController
        
        movieDetailsViewController.movie = movie
        
        TableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}
