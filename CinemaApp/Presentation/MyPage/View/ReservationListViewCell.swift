//
//  ReservationListViewCell.swift
//  CinemaApp
//
//  Created by 박현렬 on 4/26/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class ReservationListViewCell: UITableViewCell{
    
    let movieImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(named: "LabelTextColor")
    }
    
    let dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = UIColor(named: "LabelTextColor")
    }
    
    let priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = UIColor(named: "LabelTextColor")
    }
    
    let numberLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = UIColor(named: "LabelTextColor")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
        contentView.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func setupLayout() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(numberLabel)
        
        movieImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.top)
            $0.leading.equalTo(movieImageView.snp.trailing).offset(16)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
    }
    
    func configure(reservation: Reservation) {
        
        if let posterPath = reservation.posterPath{
            let url = URL(string: "https://image.tmdb.org/t/p/w400\(posterPath)")
            movieImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = reservation.movieTitle
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd / HH:mm"
        dateLabel.text = dateFormatter.string(from: reservation.date)
        
        priceLabel.text = "가격: \(reservation.price)"
        numberLabel.text = "인원: \(reservation.people)"
        
        if let posterPath = reservation.posterPath {
            movieImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"))
        }
    }
}
