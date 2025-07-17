//
//  ReservationView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import UIKit

import SnapKit
import Then

class ReservationView: UIView {

    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "person")
    }

    private let movieTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }

    private let informStackView = UIStackView().then {
        $0.axis = .vertical
    }

    private let dateStackView = SymbolLabelStackView(
        symbol: UIImage(named: "calendar") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    private let peopleStackView = SymbolLabelStackView(
        symbol: UIImage(named: "calendar") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    private let amountStackView = SymbolLabelStackView(
        symbol: UIImage(named: "calendar") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: ReservationDetail) {
        // TODO: item.posterURL 또는 item.posterImage를 사용하여 posterImageView에 이미지 로드
        // 예시: URLSession을 사용하여 이미지 로드
        // if let urlString = item.posterURL, let url = URL(string: urlString) {
        //     URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        //         if let data = data, let image = UIImage(data: data) {
        //             DispatchQueue.main.async {
        //                 self?.posterImageView.image = image
        //             }
        //         }
        //     }.resume()
        // }

        movieTitleLabel.text = item.movieTitle
        dateStackView.label.text = String("ㅁㅇㄴㅁㅇㅁㄴㅇ")
        peopleStackView.label.text = String(item.numberOfPeople) + "명"
        amountStackView.label.text = String(item.amount) + "원"
    }

    private func setUI() {
        [posterImageView, movieTitleLabel, informStackView].forEach {
            self.addSubview($0)
        }

        [dateStackView, peopleStackView, amountStackView].forEach {
            informStackView.addArrangedSubview($0)
        }

        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(100) // 임시로 100pt로 고정
        }

        movieTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.height.equalTo(movieTitleLabel.font.lineHeight)
        }

        informStackView.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(movieTitleLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

