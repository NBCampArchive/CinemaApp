//
//  LikeMovieViewController.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/26/24.
//

import UIKit

class LikeMovieViewController: UIViewController{
    
    @IBOutlet weak var likeMovieTableView: UITableView!
    
    var likeMovieList: [LikedMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        likeMovieTableView.backgroundColor = UIColor(named: "BackgroundColor")
        navigationItem.title = "Liked Movies"
        
        likeMovieTableView.delegate = self
        likeMovieTableView.dataSource = self
        fetchLikedMovies()
    }
    private func fetchLikedMovies() {
        likeMovieList = decodeUserDefaultsValue(key: "likedMovies", type: [LikedMovie].self) ?? []
        likeMovieTableView.reloadData()
    }
    
    private func decodeUserDefaultsValue<T: Decodable>(key: String, type: T.Type) -> T? {
        let defaults = UserDefaults.standard
        if let encodedData = defaults.data(forKey: key) {
            return try? JSONDecoder().decode(type, from: encodedData)
        }
        return nil
    }
}
extension LikeMovieViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeMovieTableCell", for: indexPath) as! LikeMovieTableCell
        let likeMovie = likeMovieList[indexPath.row]
        
        cell.configure(likeMovie: likeMovie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pushVC = UIStoryboard(name: "MovieDetails", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            print("Failed to instantiate MovieDetailsViewController")
            return
        }

        pushVC.movieId = likeMovieList[indexPath.row].id
        present(pushVC, animated: true)
    }
}
