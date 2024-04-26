//
//  MovieDetailsViewController.swift
//  CinemaApp
//
//  Created by 강태영 on 4/25/24.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    
    
    @IBOutlet weak var detailimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var releasedateLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var movieDetail: MovieDetail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        getDetailMovie()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor(named: "LabelTextColor")
        stackView.backgroundColor = UIColor.clear
        scrollView.backgroundColor = UIColor.clear
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.textColor = UIColor(named: "LabelTextColor")
        ratingLabel.backgroundColor = UIColor.clear
        ratingLabel.textColor = UIColor(named: "LabelTextColor")
        releasedateLabel.backgroundColor = UIColor.clear
        releasedateLabel.textColor = UIColor(named: "LabelTextColor")
        reservationButton.backgroundColor = UIColor(named: "customPrimaryColor")
        
        reservationButton.layer.cornerRadius = 10
        reservationButton.backgroundColor = UIColor.blue
        reservationButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    func getDetailMovie() {
        MovieListApiManager.shared.getMovieDetail(id: 693134) { result in
            switch result {
            case .success(let movies):
                print("MovieDetail: \(movies)")
                self.movieDetail = movies
                if let movieDetail = self.movieDetail {
                    print("영화 제목입니다!!!!!!!!!!!!!!!! \(movieDetail.title)")
                    DispatchQueue.main.async {
                        self.titleLabel.text = movieDetail.title
                        self.descriptionLabel.text = movieDetail.overview
                        self.ratingLabel.text = String(format: "%.1f", movieDetail.voteAverage)
                        self.releasedateLabel.text = movieDetail.releaseDate
                        if let posterPath = movieDetail.posterPath {
                            self.detailimageView.image = UIImage(named: posterPath)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
        // 컨텐츠의 크기 설정 (API에서 가져올 때 동적으로 설정)
        scrollView.contentSize = CGSize(width: 393, height: 680)
        
        // 스크롤뷰의 스크롤 가능 여부 설정
        scrollView.isScrollEnabled = true
        
        // 스크롤뷰의 delegate 설정
        scrollView.delegate = self
        
        // API로부터 데이터를 받아와서 스크롤뷰에 추가하는 함수 호출
        getDataAndUpdateScrollView()
        
        
        // UIScrollViewDelegate 메서드 구현
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // 스크롤이 발생할 때 호출되는 메서드
            print("스크롤 발생")
        }
        
        // API로부터 데이터를 받아와서 스크롤뷰에 추가하는 함수
        func getDataAndUpdateScrollView() {
        }
    }
}





