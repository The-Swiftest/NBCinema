//
//  MovieRankingCell.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import UIKit

class MovieRankingCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let containerView = UIView().then {
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = false
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 15)
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.25
    }
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let rankingBadge = UILabel().then {
        $0.font = .systemFont(ofSize: 50, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .reverseSystem
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.textAlignment = .center
    }
    
    private let bookingRateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .gray3
        $0.numberOfLines = 1
    }
    
    private let voteAverageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
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
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowPath = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: 16
        ).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        bookingRateLabel.text = nil
        voteAverageLabel.text = nil
    }
    
    // MARK: - Setup Methods
    
    func setupUI() {
        contentView.addSubview(containerView)
        
        [posterImageView, rankingBadge]
            .forEach { containerView.addSubview($0) }
        
        [titleLabel, ratingHStackView]
            .forEach { contentView.addSubview($0) }
        
        [bookingRateLabel, voteAverageLabel]
            .forEach { ratingHStackView.addArrangedSubview($0) }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(1.15)
        }
        
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        rankingBadge.snp.makeConstraints {
            $0.top.equalTo(posterImageView)
            $0.leading.equalTo(posterImageView).inset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        ratingHStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func configure(movie: Movie, ranking: Int) {
        titleLabel.text = movie.title
        bookingRateLabel.text = "예매율 \(String(format: "%.1f", movie.bookingRate))%"
        voteAverageLabel.text = "★\(String(format: "%.1f", movie.voteAverage))"
        rankingBadge.text = "\(ranking)"
        
        if let posterURL = movie.posterURL {
            posterImageView.loadImage(from: posterURL)
        } else {
            posterImageView.image = nil
            posterImageView.backgroundColor = .systemGray5
        }
    }
}
