//
//  MovieInfoStatsView.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import UIKit
import SnapKit
import Then

class MovieInfoStatsView: UIView {
    
    // MARK: - UI Components
    
    private let containerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 16
    }
    
    private let bookingRateView = createInfoView(imageName: "popularity", title: "예매율")
    private let ratingView = createInfoView(imageName: "vote_rate", title: "평점")
    private let runtimeView = createInfoView(imageName: "lucide_clock", title: "상영시간")
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(bookingRateView)
        containerStackView.addArrangedSubview(ratingView)
        containerStackView.addArrangedSubview(runtimeView)
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
//            $0.height.equalTo(60)
        }
    }
    
    private static func createInfoView(imageName: String, title: String) -> UIView {
        let hStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 10
        }
        
        let iconImageView = UIImageView().then {
            $0.image = UIImage(named: imageName)
            $0.contentMode = .scaleAspectFit
        }
        
        let textVStackView = UIStackView().then {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 6
        }
        
        let titleLabel = UILabel().then {
            $0.text = title
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .secondaryLabel
        }
        
        let valueLabel = UILabel().then {
            $0.font = .boldSystemFont(ofSize: 14)
            $0.textColor = .label
            $0.tag = 100
        }
        
        textVStackView.addArrangedSubview(titleLabel)
        textVStackView.addArrangedSubview(valueLabel)
        
        hStackView.addArrangedSubview(iconImageView)
        hStackView.addArrangedSubview(textVStackView)
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(44)
        }
        
        return hStackView
    }
    
    // MARK: - Public Methods
    
    func configure(bookingRate: Double, rating: Double, runtime: String) {
        (bookingRateView.viewWithTag(100) as? UILabel)?.text = String(format: "%.1f%%", bookingRate)
        (ratingView.viewWithTag(100) as? UILabel)?.text = String(format: "%.1f", rating)
        (runtimeView.viewWithTag(100) as? UILabel)?.text = runtime
    }
}
