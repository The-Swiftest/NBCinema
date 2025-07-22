//
//  MovieDetailHeaderView.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import UIKit
import SnapKit
import Then

protocol MovieDetailHeaderViewDelegate: AnyObject {
    func headerViewFavoriteButtonTapped()
}

class MovieDetailHeaderView: UIView {
    
    weak var delegate: MovieDetailHeaderViewDelegate?
    
    // MARK: - UI Components
    
    private let backdropImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray5
    }
    
    private let gradientView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let movieInfoContainerView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 26)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let favoriteButton = UIButton().then {
        $0.setImage(UIImage(named: "bookmark"), for: .normal)
        $0.setImage(UIImage(named: "bookmark_fill"), for: .selected)
        $0.tintColor = .systemRed
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        addSubview(backdropImageView)
        addSubview(gradientView)
        addSubview(movieInfoContainerView)
        addSubview(favoriteButton)
        
        movieInfoContainerView.addSubview(titleLabel)
        movieInfoContainerView.addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backdropImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalTo(backdropImageView)
        }
        
        movieInfoContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading).offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(40)
        }
    }
    
    private func setupGradient() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.3).cgColor,
                UIColor.black.withAlphaComponent(0.7).cgColor
            ]
            gradientLayer.locations = [0.0, 0.6, 1.0]
            
            self.gradientView.layer.addSublayer(gradientLayer)
        }
    }
    
    private func setupActions() {
        favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: - Public Methods
    
    func configure(
        title: String,
        subtitle: String,
        backdropURL: URL?,
        isFavorite: Bool
    ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        favoriteButton.isSelected = isFavorite
        
        if let backdropURL = backdropURL {
            backdropImageView.loadImage(from: backdropURL)
        }
    }
    
    // MARK: - Actions
    
    @objc private func favoriteButtonTapped() {
        delegate?.headerViewFavoriteButtonTapped()
    }
}
