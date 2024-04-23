//
//  ViewController.swift
//  CinemaApp
//
//  Created by YJ on 4/22/24.
//

import UIKit

class SerachMovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    let urlString = "https://api.themoviedb.org/3/search/movie"
    
    let interSpacing: CGFloat = 2
    var imageList: [UIImage] = []
    let imageNameList = ["bodercoly", "boldGuy", "brain", "cat", "dance", "game", "heart", "pepe" , "scary", "ugly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListCollectionView.dataSource = self
        movieListCollectionView.delegate = self
        makeImage()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        getData(query: "12")
    }
    
    func getData(query: String) {
    
        guard let url = URL(string: urlString) else { return }
        // 파라미터나 헤더를 추가하고 싶을때 이걸로 생성 -> URLComponents -> 이걸 사용할 때는 URLRequest 안에 components?.url 넣기
        // 헤더나 파라미터 필요 없는 경우 -> URLRequest 만 생성.
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
          "Authorization": ""
        ]
        //
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Movie.self, from: data)
                print("result: \(result)")
            } catch {
                print("error: \(error)")
            }
        }
        .resume()
    }
    
    func makeImage() {
        for imageName in imageNameList {
            let newImage = UIImage(named: imageName) ?? UIImage(systemName: "folder.fill")!
            imageList.append(newImage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.movieListCollectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.indentifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        let image = imageList[indexPath.item]
        cell.movieImage.image = image
        cell.movieImage.contentMode = .scaleAspectFill
        cell.movieName.text = imageNameList[indexPath.item]
        
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
