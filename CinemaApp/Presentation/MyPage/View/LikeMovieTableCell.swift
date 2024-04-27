//
//  LikeMovieTableCell.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/26/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class LikeMovieTableCell: UITableViewCell{
    
    let posterImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    let titleLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.numberOfLines = 0
        $0.textColor = UIColor(named: "LabelTextColor")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
        
        setupLayout()
    }
    
    func setupLayout(){
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        
        posterImageView.snp.makeConstraints{
            $0.leading.equalTo(contentView).offset(16)
            $0.top.equalTo(contentView).offset(10)
            $0.bottom.equalTo(contentView).offset(-10)
            $0.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.centerY.equalTo(posterImageView)
        }
    }
    
    func configure(likeMovie: LikedMovie){
        titleLabel.text = likeMovie.title
        if let posterPath = likeMovie.posterPath{
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            posterImageView.kf.setImage(with: url)
        }
    }
}
