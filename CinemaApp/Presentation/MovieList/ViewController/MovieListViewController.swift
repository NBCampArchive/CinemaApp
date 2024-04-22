//
//  ViewController.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/22/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var categorySegementController: UISegmentedControl!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupCollectionView()
        setupSegement()
        fetchMovieList(listType: "now_playing")
    }
    
    func setupCollectionView() {
        movieCollectionView.layer.cornerRadius = 24
        movieCollectionView.layer.masksToBounds = true
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
    }
    
    func setupSegement(){
        // 기존 세그먼트 제거
        categorySegementController.removeAllSegments()
        
        // 새로운 세그먼트 추가 및 텍스트 설정
        categorySegementController.insertSegment(withTitle: "Playing", at: 0, animated: false)
        categorySegementController.insertSegment(withTitle: "Popular", at: 1, animated: false)
        categorySegementController.insertSegment(withTitle: "TopRated", at: 2, animated: false)
        categorySegementController.insertSegment(withTitle: "UpComing", at: 3, animated: false)
        
        // 세그먼트 텍스트 스타일 설정
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.white
        ]
        categorySegementController.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15),
            .foregroundColor: UIColor.black
        ]
        categorySegementController.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        // 첫 번째 세그먼트를 선택된 상태로 설정
        categorySegementController.selectedSegmentIndex = 0
    }
    
    @IBAction func categorySegmentChanged(_ sender: UISegmentedControl) {
        let listType: String
        
        switch sender.selectedSegmentIndex {
        case 0:
            listType = "now_playing"
        case 1:
            listType = "popular"
        case 2:
            listType = "top_rated"
        case 3:
            listType = "upcoming"
        default:
            listType = "now_playing"
        }
        
        fetchMovieList(listType: listType)
    }
    
    func fetchMovieList(listType: String){
        MovieListApiManager.shared.fetchMovieList(listType: listType, page: 1) { result in
            switch result {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(image: UIImage(named: "placeholder"), title: "Title", description: "description")
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 원하는 셀의 크기를 반환합니다.
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
