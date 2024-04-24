//
//  MovieCollectionViewCell.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/22/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher
import Alamofire

class MovieCollectionViewCell: UICollectionViewCell{
    
    //MARK: - Properties
    
    var movieData: Movie?
    
    var isLiked: Bool = false
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.textColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private let likeButton = UIButton().then {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Add Like"
        configuration.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white]))
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = UIColor(red: 0.07, green: 0.18, blue: 0.31, alpha: 1.00)
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .dynamic
        
        // titleTextAttributesTransformer를 사용하여 타이틀의 글꼴 설정
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .boldSystemFont(ofSize: 20)
            return outgoing
        }

        var likedConfiguration = configuration
        likedConfiguration.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.systemPink]))
        likedConfiguration.baseBackgroundColor = .red

        $0.configuration = configuration
        $0.configurationUpdateHandler = { button in
            var updatedConfiguration = button.configuration
            updatedConfiguration?.image = button.isSelected ? likedConfiguration.image : configuration.image
            updatedConfiguration?.title = button.isSelected ? "Remove Like" : "Add Like"
            button.configuration = updatedConfiguration
        }
    }
    
    private func checkIfLiked(_ movie: Movie) -> Bool {
        let likedMovies = decodeUserDefaultsValue(key: "likedMovies", type: [LikedMovie].self) ?? []
        return likedMovies.contains(where: { $0.id == movie.id })
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        guard let movie = self.movieData else { return }
        
        var likedMovies = decodeUserDefaultsValue(key: "likedMovies", type: [LikedMovie].self) ?? []
        
        if sender.isSelected {
            let likedMovie = LikedMovie(id: movie.id, posterPath: movie.posterPath, title: movie.title)
            likedMovies.append(likedMovie)
        } else {
            likedMovies.removeAll(where: { $0.id == movie.id })
        }
        
        encodeUserDefaultsValue(value: likedMovies, key: "likedMovies")
    }
    
    private func encodeUserDefaultsValue<T: Encodable>(value: T, key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try? JSONEncoder().encode(value)
        defaults.set(encodedData, forKey: key)
    }

    private func decodeUserDefaultsValue<T: Decodable>(key: String, type: T.Type) -> T? {
        let defaults = UserDefaults.standard
        if let encodedData = defaults.data(forKey: key) {
            return try? JSONDecoder().decode(type, from: encodedData)
        }
        return nil
    }
    
    func printLikedMovies() {
        let likedMovies = decodeUserDefaultsValue(key: "likedMovies", type: [LikedMovie].self) ?? []
        
        print("Liked Movies:")
        likedMovies.forEach { print("ID: \($0.id), Title: \($0.title), Poster Path: \($0.posterPath ?? "")") }
    }
    
    private let navigationButton = UIButton().then{
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Buy Ticket"
        configuration.image = UIImage(systemName: "creditcard.circle.fill")
        configuration.imagePadding = 10 // 이미지와 타이틀 사이의 간격 조정
        configuration.imagePlacement = .leading // 이미지를 타이틀의 앞에 배치
        configuration.baseBackgroundColor = UIColor(red: 0.07, green: 0.18, blue: 0.31, alpha: 1.00)
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .capsule
        
        // titleTextAttributesTransformer를 사용하여 타이틀의 글꼴 설정
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .boldSystemFont(ofSize: 20)
            return outgoing
        }
        
        $0.configuration = configuration
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        printLikedMovies()
    }
    
    func setupLayout(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(navigationButton)
        
        contentView.backgroundColor = .white
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(400)
        }
        
        likeButton.snp.makeConstraints{
            $0.bottom.equalTo(navigationButton.snp.top).offset(-8)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        navigationButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func configure(with movie: Movie) {
        self.movieData = movie
        imageView.image = nil
        
        isLiked = checkIfLiked(movie)
        likeButton.isSelected = isLiked
        
        if let imageURL = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500\(imageURL)"
            let fullImageURL = URL(string: urlString)
            imageView.kf.setImage(with: fullImageURL)
        }
        
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
    }
}
