//
//  MovieListViewController.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit
import SnapKit
import Then

class MovieListViewController: UIViewController {
    
    // MARK: - Constants
    
    // MARK: - Properties
    
    typealias DataSource = UICollectionViewDiffableDataSource<MovieSection, Movie>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MovieSection, Movie>
    
    private var dataSource: DataSource?
    private let repository: MovieRepository
    
    private var nowPlayingMovies: [Movie] = []
    private var popularMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    private var topRatedMovies: [Movie] = []
    
    
    // MARK: - Closures
    
    // MARK: - UI Components
    
    private let headerView = HeaderView(.logo)
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCompositionalLayout()
    ).then {
        $0.backgroundColor = .systemBackground
        $0.delegate = self
    }
    
    // MARK: - Initializers
    
    init(repository: MovieRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataSource()
        fetchMovies()
    }
    
    // MARK: - Setup Methods
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(headerView)
        view.addSubview(collectionView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupDataSource() {
        let posterCellRegistration = UICollectionView.CellRegistration<MoviePosterCell, Movie> {
            cell, indexPath, movie in
            cell.configure(movie: movie)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<MovieSectionHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { headerView, elementKind, indexPath in
            let section = MovieSection(rawValue: indexPath.section)!
            headerView.configure(title: section.title)
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, movie in
            return collectionView.dequeueConfiguredReusableCell(
                using: posterCellRegistration, for: indexPath, item: movie
            )
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            let section = MovieSection(rawValue: indexPath.section)!
            if section.showHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration, for: indexPath
                )
            }
            return nil
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    private func fetchMovies() {
        Task {
            do {
                async let nowPlaying = repository.fetchNowPlayingMovies()
                async let popular = repository.fetchPopularMovies()
                async let upcoming = repository.fetchUpcomingMovies()
                async let topRated = repository.fetchTopRatedMovies()
                
                nowPlayingMovies = try await nowPlaying
                popularMovies = try await popular
                upcomingMovies = try await upcoming
                topRatedMovies = try await topRated
                
                await MainActor.run {
                    setupSnapShot()
                }
                
            } catch {
                await MainActor.run {
                    print("❌ 영화 데이터 로드 실패: \(error)")
                    // 에러 발생 시 빈 데이터로 스냅샷 적용
                    setupSnapShot()
                }
            }
        }
    }
    
    func setupSnapShot() {
        var snapshot = Snapshot()
        snapshot.appendSections(MovieSection.allCases)
        
        snapshot.appendItems(nowPlayingMovies, toSection: .nowPlaying)
        snapshot.appendItems(popularMovies, toSection: .popular)
        snapshot.appendItems(upcomingMovies, toSection: .upcoming)
        snapshot.appendItems(topRatedMovies, toSection: .topRated)
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Extensions

extension MovieListViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let section = MovieSection(rawValue: sectionIndex)!
            
            switch section {
            case .nowPlaying:
                return self.createRankingSection()
            default:
                return self.createPosterSection(sectionType: section)
            }
        }
    }
    
    private func createRankingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(370)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.62),
            heightDimension: .estimated(370)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 30
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createPosterSection(sectionType: MovieSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(230)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.36),
            heightDimension: .estimated(230)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0)
        
        
        if sectionType.showHeader {
            section.boundarySupplementaryItems = [createSectionHeader()]
        }
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section: \(indexPath.section), item: \(indexPath.item)")
    }
}
