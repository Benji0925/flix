//
//  ViewController.swift
//  flix
//
//  Created by JSU Makerspace  on 2/8/22.
//

import UIKit
import AlamofireImage
class MoviesViewController: UIViewController, UITableViewDataSource,
                            UITableViewDelegate{

    
    
    
   
    @IBOutlet weak var tableview: UITableView!
    var movies = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.tableview.reloadData()
                
//                print(dataDictionary)
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
        tableview.rowHeight = 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w200"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        let test = cell.posterView.af.setImage(withURL: posterUrl!)
        
        print(posterUrl)
        return cell
    }
    


}

