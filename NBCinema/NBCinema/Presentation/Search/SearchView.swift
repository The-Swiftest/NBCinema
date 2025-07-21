//
//  SearchView.swift
//  NBCinema
//
//  Created by estelle on 7/20/25.
//

import UIKit
import Then
import SnapKit

private enum Const {
    static let cellHeight: CGFloat = 260.0
    
    static let lineSpacing: CGFloat = 28.0
    static let itemSpacing: CGFloat = 28.0
    
    static let sectionInsetLeft: CGFloat = 20.0
    static let sectionInsetRight: CGFloat = 20.0
}

class SearchView: UIView {
    
    private let headerView = HeaderView(.logo)
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "검색어를 입력해주세요."
        $0.searchBarStyle = .minimal
        $0.backgroundImage = UIImage()
        $0.autocapitalizationType = .none
        $0.searchTextField.textColor = .label
        $0.searchTextField.font = .systemFont(ofSize: 14, weight: .regular)
        $0.searchTextField.frame.size.height = 44
        $0.tintColor = .nbcMain
        $0.searchTextField.borderStyle = .none
        $0.searchTextField.layer.borderWidth = 1
        $0.searchTextField.layer.cornerRadius = 8
        $0.searchTextField.clipsToBounds = true
        
        // 검색 아이콘, clear 버튼 위치 조정
        $0.setPositionAdjustment(UIOffset(horizontal: -10, vertical: 0), for: .clear)
        $0.setPositionAdjustment(UIOffset(horizontal: 10, vertical: 0), for: .search)
    }
    
    private let genreTitle = UILabel().then {
        $0.text = "추천 장르"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .reverseSystem
    }
    
    let genreTagView = GenreTagListView()
    
    private lazy var genreStackView = UIStackView(arrangedSubviews: [genreTitle, genreTagView]).then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createFlowLayout()
    ).then {
        $0.backgroundColor = .systemBackground
        $0.register(MoviePosterCell.self, forCellWithReuseIdentifier: "MoviePosterCell")
        $0.register(SearchSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchSectionHeaderView.reuseIdentifier)
        $0.isHidden = true
    }
    
    // 검색 결과가 없을 때 보여줄 라벨
    private let emptyLabel = UILabel().then {
        $0.text = "조회된 영화가 없습니다."
        $0.textColor = .gray3
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .center
    }
    
    // 다크모드 전환 감지
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        searchBar.searchTextField.layer.borderColor = UIColor.borderDynamic.cgColor
        searchBar.searchTextField.layer.backgroundColor = UIColor.gray4Dynamic.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UICollectionViewLayout 생성
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let itemSize: CGFloat = (UIScreen.main.bounds.width - 42 - Const.itemSpacing) / 2
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Const.lineSpacing
        layout.minimumInteritemSpacing = Const.itemSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: Const.sectionInsetLeft, bottom: 0, right: Const.sectionInsetRight)
        layout.itemSize = CGSize(width: itemSize, height: Const.cellHeight)
        return layout
    }
    
    // MARK: - UI 구성
    
    private func setupUI() {
        // 검색 아이콘 색상 설정
        if let leftIcon = searchBar.searchTextField.leftView as? UIImageView {
            leftIcon.tintColor = .nbcMain
            leftIcon.image = leftIcon.image?.withRenderingMode(.alwaysTemplate)
        }
        
        backgroundColor = .systemBackground
        [headerView, searchBar, genreStackView, collectionView].forEach { addSubview($0) }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        genreStackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // 추천 장르 뷰와 검색 결과 뷰 toggle
    func setHiddenGenreStackView(_ isHidden: Bool) {
        genreStackView.isHidden = isHidden
        collectionView.isHidden = !isHidden
    }
    
    // 검색 결과가 비었을 때 emptyLabel 표시
    func updateCollectionViewBackground(isEmpty: Bool) {
        collectionView.backgroundView = isEmpty ? emptyLabel : nil
    }
}
