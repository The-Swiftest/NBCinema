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
    
    // MARK: - Properties
    
    typealias DataSource = UICollectionViewDiffableDataSource<MovieSection, Movie>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MovieSection, Movie>
    
    private var dataSource: DataSource?
    private let repository: MovieRepository
    
    private var nowPlayingMovies: [Movie] = []
    private var popularMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    private var topRatedMovies: [Movie] = []
    
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
        let rankingCellRegistration = UICollectionView.CellRegistration<MovieRankingCell, Movie> {
            cell, indexPath, movie in
            cell.configure(movie: movie, ranking: indexPath.item + 1)
        }
        
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
        
        dataSource = DataSource(collectionView: collectionView) {
            collectionView, indexPath, movie in
            let section = MovieSection(rawValue: indexPath.section)!
            
            switch section {
            case .nowPlaying:
                return collectionView.dequeueConfiguredReusableCell(
                    using: rankingCellRegistration, for: indexPath, item: movie
                )
            default:
                return collectionView.dequeueConfiguredReusableCell(
                    using: posterCellRegistration, for: indexPath, item: movie
                )
            }
        }
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            let section = MovieSection(rawValue: indexPath.section)!
            
            if section.showHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration, for: indexPath
                )
            }
            return nil
        }
    }
    
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
                    updateSnapShot()
                }
                
            } catch {
                await MainActor.run {
                    print("❌ 영화 데이터 로드 실패: \(error)")
                    // 에러 발생 시 빈 데이터로 스냅샷 적용
                    updateSnapShot()
                }
            }
        }
    }
    
    func updateSnapShot() {
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

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section: \(indexPath.section), item: \(indexPath.item)")
    }
}
