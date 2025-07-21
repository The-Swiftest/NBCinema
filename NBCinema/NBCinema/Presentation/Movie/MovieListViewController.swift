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

    private lazy var dataSource = makeDataSource(collectionView: collectionView)
    
    private let viewModel: MovieListViewModel
    private weak var coordinator: MovieListCoordinator?
    
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
    
    init(viewModel: MovieListViewModel, coordinator: MovieListCoordinator) {
            self.viewModel = viewModel
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.action(.fetchMovies)
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
    
    func makeDataSource(collectionView: UICollectionView) -> DataSource {
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
        
        let dataSource = DataSource(collectionView: collectionView) {
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
        
        dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            let section = MovieSection(rawValue: indexPath.section)!
            
            if section.showHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration, for: indexPath
                )
            }
            return nil
        }
        
        return dataSource
    }
    
    // MARK: - Methods
    
    func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            self?.updateUI(state: state)
        }
    }
    
    func updateUI(state: MovieListViewModel.State) {
        if let error = state.error {
            print("❌ 영화 로드 실패: \(error)")
            // TODO: showAlert coordinator에서 한번에 처리
        }
        
        updateSnapShot(state: state)
    }
    
    func updateSnapShot(state: MovieListViewModel.State) {
        var snapshot = Snapshot()
        snapshot.appendSections(MovieSection.allCases)
        
        snapshot.appendItems(state.nowPlayingMovies, toSection: .nowPlaying)
        snapshot.appendItems(state.popularMovies, toSection: .popular)
        snapshot.appendItems(state.upcomingMovies, toSection: .upcoming)
        snapshot.appendItems(state.topRatedMovies, toSection: .topRated)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Extensions

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        coordinator?.showMovieDetail(movieId: movie.id)
    }
}
