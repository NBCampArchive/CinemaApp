//
//  ViewController.swift
//  CinemaApp
//
//  Created by YJ on 4/22/24.
//

import UIKit
import Kingfisher

class SearchMovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieListCollectionView: UICollectionView!

    // TODO: Key를 발급받아 채워주세요.
    let authenticationKey = ""
    let urlString = "https://api.themoviedb.org/3/search/movie"
    let interSpacing: CGFloat = 2
    
    var movieList: [Results] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieListCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.delegate = self
        view.backgroundColor = UIColor(named: "BackgroundColor")
        getData(query: "12")
        setSearchBar()
    }
    
    func setSearchBar() {
        searchBar.placeholder = "영화 제목을 검색하세요."
    }
    
    func getData(query: String) {
        guard let url = URL(string: urlString) else { return }
        // 파라미터 or 헤더를 추가 -> URLComponents -> URLRequest 안에 components?.url 넣기
        // 헤더 or 파라미터 필요 x -> URLRequest만 생성
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // 파라미터 설정
        let qureyParam = URLQueryItem(name: "query", value: query)
        let languageParam = URLQueryItem(name: "language", value: "ko-KR")
        let queryItems = [qureyParam, languageParam]
        components?.queryItems = queryItems
        
        guard let componentUrl = components?.url else { return }
        var urlRequest = URLRequest(url: componentUrl)
        
        // 해더 설정
        urlRequest.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(authenticationKey)"
        ]
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Movies.self, from: data)
                self.movieList = result.results
            } catch {
                print("error: \(error)")
            }
        }
        .resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.movieListCollectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.indentifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = movieList[indexPath.item]
        
        cell.movieImage.contentMode = .scaleAspectFill
        cell.movieImage.backgroundColor = UIColor(named: "BackgroundColor")
        cell.movieImage.tintColor = UIColor(named: "LabelTextColor")
        cell.movieName.backgroundColor = UIColor(named: "customPrimaryColor")
        cell.movieName.tintColor = UIColor(named: "LabelTextColor")
        cell.movieName.text = movie.title
        if let path = movie.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            let placeholderImage = UIImage(systemName: "movieclapper")
            cell.movieImage.kf.setImage(with: url, placeholder: placeholderImage)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 화면의 너비
        let screenWidth = collectionView.frame.width
        // 한 줄에 몇 개 둘건지
        let lineItemCount: CGFloat = 3
        // Cell 사이 간격들의 합
        let totalInterSpacing: CGFloat = interSpacing * (lineItemCount - 1)
        // 아이텀 하나 크기
        let itemWidth = (screenWidth - totalInterSpacing) / lineItemCount
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interSpacing
    }
    
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        getData(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}


