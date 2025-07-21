//
//  MovieDetailContentView.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import UIKit
import SnapKit
import Then

class MovieDetailContentView: UIView {
    
    // MARK: - UI Components
    
    private let directorLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .label
        $0.text = "감독"
    }
    
    private let directorNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .label
    }
    
    private let castLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .label
        $0.text = "출연"
    }
    
    private let castTagListView = CastTagListView()
    
    private let overviewLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .label
        $0.text = "줄거리"
    }
    
    private let overviewContentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .label
        $0.numberOfLines = 0
    }
    
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
        addSubview(directorLabel)
        addSubview(directorNameLabel)
        addSubview(castLabel)
        addSubview(castTagListView)
        addSubview(overviewLabel)
        addSubview(overviewContentLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        directorLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        directorNameLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        castLabel.snp.makeConstraints {
            $0.top.equalTo(directorNameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }
        
        castTagListView.snp.makeConstraints {
            $0.top.equalTo(castLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(castTagListView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
        }
        
        overviewContentLabel.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    
    func configure(director: String?, cast: [String], overview: String) {
        directorNameLabel.text = director ?? "정보 없음"
        castTagListView.configure(castList: cast)
        overviewContentLabel.text = overview.isEmpty ? "줄거리 정보가 없습니다." : overview
    }
}
