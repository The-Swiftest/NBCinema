//
//  MoviePosterCell.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import UIKit
import SnapKit
import Then

class MoviePosterCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .reverseSystem
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.textAlignment = .center
    }
    
    private let bookingRateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .gray3
        $0.numberOfLines = 1
    }
    
    private let voteAverageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .nbcMain
        $0.numberOfLines = 1
    }
    
    private let ratingHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        bookingRateLabel.text = nil
        voteAverageLabel.text = nil
    }
    
    // MARK: - Setup Methods
    
    func setupUI() {
        [posterImageView, titleLabel, ratingHStackView]
            .forEach { contentView.addSubview($0) }
        
        [bookingRateLabel, voteAverageLabel]
            .forEach { ratingHStackView.addArrangedSubview($0) }
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(1.24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        ratingHStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func configure(movie: Movie) {
        titleLabel.text = movie.title
        bookingRateLabel.text = "예매율 \(String(format: "%.1f", movie.bookingRate))%"
        voteAverageLabel.text = "★\(String(format: "%.1f", movie.voteAverage))"
        
        if let posterURL = movie.posterURL {
            posterImageView.loadImage(from: posterURL)
        } else {
            posterImageView.image = nil
            posterImageView.backgroundColor = .systemGray5
        }
    }
}
