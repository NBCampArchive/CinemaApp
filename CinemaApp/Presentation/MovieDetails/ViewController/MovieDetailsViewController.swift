//
//  MovieDetailsViewController.swift
//  CinemaApp
//
//  Created by 강태영 on 4/25/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    

    
    @IBOutlet weak var detailimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releasedateLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!
    
    private var randomNumber: Int32? {
        (1...2147483647).randomElement()
    }
//    var scrollView: UIScrollView! {
//            // 스크롤 뷰 생성
//            let scrollView = UIScrollView(frame: CGRect(x: 0, y: 449.33, width: 393, height: 206))
//            scrollView.backgroundColor = .lightGray
//            return scrollView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let movie_id = randomNumber,
           let url = URL(string: "https://api.themoviedb.org/3/movie/\("movie_id")") {
            //네트워크 요청
            
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                
                if let error = error {
                //MARK: 에러 처리
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode)
                else{
                    //MARK: 에러 처리
                    return
                }
                
                if let data = data,
                   let MovieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                    
                    DispatchQueue.main.async {
//                        self?.titleLabel.text = MovieDetail.movieTitle
//                        self?.detailLabel.text = MovieDetail.movieDetail
//                        self?.ratedLabel.text = "\(MovieDetail.rating)"
//                        self?.releasedateLabel.text = "\(MovieDetail.releaseDate)"
                    }
                    
                    let imageRequest = URLRequest(url: url)
                    let imageDataTask = URLSession.shared.dataTask(with: imageRequest) { data, response, error in
                        
                        if let error = error {
                        //MARK: 에러 처리
                        }
                        
                        guard let response = response as? HTTPURLResponse,
                              (200...299).contains(response.statusCode)
                        else{
                            //MARK: 에러 처리
                            return
                        }
                        
                        if let data = data{
                            
                            DispatchQueue.main.async{
                                let image = UIImage(data: data)
                                self?.detailimageView.image = image
                            }
                        }
                    }
//                    print(MovieDetail.movieTitle)
//                    print(MovieDetail.movieDetail)
//                    print(MovieDetail.movieImage)
//                    print(MovieDetail.rating)
//                    print(MovieDetail.releaseDate)
                    
                }
                
            }
                task.resume()
                
            }
            
            // Label 초기화
            let descriptionLabel = UILabel()
        descriptionLabel.text = "\("이거 바뀌나?")"







        descriptionLabel.numberOfLines = 0 // 여러 줄로 텍스트를 표시할 수 있도록 설정
        descriptionLabel.sizeToFit() // 라벨의 크기를 텍스트에 맞게 자동으로 조정
            
            
//            // Label을 ScrollView에 추가합니다.
//            scrollView.addSubview(detailLabel)
//
//            // ScrollView를 뷰에 추가합니다.
//            view.addSubview(scrollView)
//
            
            
        }
    }



