//
//  ViewController.swift
//  CinemaApp
//
//  Created by YJ on 4/22/24.
//

import UIKit

class SerachMovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    let interSpacing: CGFloat = 2
    var imageList: [UIImage] = []
    let imageNameList = ["bodercoly", "boldGuy", "brain", "cat", "dance", "game", "heart", "pepe" , "scary", "ugly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListCollectionView.dataSource = self
        movieListCollectionView.delegate = self
        makeImage()
        view.backgroundColor = UIColor(named: "BackgroundColor")
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
