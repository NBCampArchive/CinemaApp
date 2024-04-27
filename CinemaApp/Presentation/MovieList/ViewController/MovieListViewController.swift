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
    
    // 영화 목록을 저장할 배열
    var movies: [Movie] = []
    var category: String = "now_playing"
    var pageIndex: Int = 1
    var totalPages: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupCollectionView()
        setupSegement()
        fetchMovieList(listType: category)
    }
    
    func setupCollectionView() {
        movieCollectionView.backgroundColor = UIColor(named: "BackgroundColor")
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }
    }
    // MARK: - SegementController
    // 세그먼트 설정
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
    
    // 세그먼트 선택 시 호출되는 메소드
    @IBAction func categorySegmentChanged(_ sender: UISegmentedControl) {
        category = getListType(for: sender.selectedSegmentIndex)
        resetData()
    }
    
    func getListType(for index: Int) -> String {
        switch index {
        case 0: return "now_playing"
        case 1: return "popular"
        case 2: return "top_rated"
        case 3: return "upcoming"
        default: return "now_playing"
        }
    }
    
    func resetData() {
        movies.removeAll()
        pageIndex = 1
        fetchMovieList(listType: category)
    }

    //MARK: - API
    func fetchMovieList(listType: String){
        MovieListApiManager.shared.fetchMovieList(listType: listType, page: self.pageIndex) { result in
            switch result {
            case .success(let movies):
                print("Category:\(listType) Page:\(self.pageIndex) Success")
                self.movies.append(contentsOf: movies.results)
                self.totalPages = movies.totalPages
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                    if self.pageIndex == 1{
                        self.movieCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.item]
        
        cell.delegate = self
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSectionIndex = collectionView.numberOfSections - 1
        let lastRowIndex = collectionView.numberOfItems(inSection: lastSectionIndex) - 1
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            // 마지막 셀에 도달한 경우
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        if pageIndex < totalPages {
            pageIndex += 1
            fetchMovieList(listType: category)
        }
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 원하는 셀의 크기를 반환합니다.
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension MovieListViewController: MovieCollectionViewCellDelegate {
    
    func movieCollectionViewCell(_ cell: MovieCollectionViewCell, didTapNavigationButtonWith movie: Movie?) {
        guard let movie = movie else {
            print("Movie is nil")
            return
        }
        print("Navigation Button Tapped")
        guard let pushVC = UIStoryboard(name: "MovieDetails", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            print("Failed to instantiate MovieDetailsViewController")
            return
        }

        pushVC.movieId = movie.id
        present(pushVC, animated: true)
    }
}
