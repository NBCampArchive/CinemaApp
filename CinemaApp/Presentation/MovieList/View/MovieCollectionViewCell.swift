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
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32, weight: .bold)
        $0.textColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .black
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
    }
    
    func setupLayout(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(navigationButton)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(400)
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
    
    func configure(imageURL: URL, title: String, description: String) {
        imageView.image = nil
        imageView.kf.setImage(with: imageURL)
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
