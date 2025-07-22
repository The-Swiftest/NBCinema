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
    
    typealias DataSource = UICollectionViewDiffableDataSource<MovieSection, MovieItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MovieSection, MovieItem>
    
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    func makeDataSource(collectionView: UICollectionView) -> DataSource {
        let rankingCellRegistration = UICollectionView.CellRegistration<MovieRankingCell, MovieItem> {
            cell, indexPath, movieItem in
            cell.configure(movie: movieItem.movie, ranking: indexPath.item + 1)
        }
        
        let posterCellRegistration = UICollectionView.CellRegistration<MoviePosterCell, MovieItem> {
            cell, indexPath, movieItem in
            cell.configure(movie: movieItem.movie)
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
            self?.updateSnapShot(state: state)
        }
        
        viewModel.onError = { [weak self] error in
                DispatchQueue.main.async {
                    self?.coordinator?.showError(error)
                }
            }
    }
    
    func updateSnapShot(state: MovieListViewModel.State) {
        var snapshot = Snapshot()
        snapshot.appendSections(MovieSection.allCases)
        
        let nowPlayingItems = state.nowPlayingMovies.map {
            MovieItem(movie: $0, section: .nowPlaying)
        }
        let popularItems = state.popularMovies.map {
            MovieItem(movie: $0, section: .popular)
        }
        let upcomingItems = state.upcomingMovies.map {
            MovieItem(movie: $0, section: .upcoming)
        }
        let topRatedItems = state.topRatedMovies.map {
            MovieItem(movie: $0, section: .topRated)
        }
        
        snapshot.appendItems(nowPlayingItems, toSection: .nowPlaying)
        snapshot.appendItems(popularItems, toSection: .popular)
        snapshot.appendItems(upcomingItems, toSection: .upcoming)
        snapshot.appendItems(topRatedItems, toSection: .topRated)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Extensions

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieItem = dataSource.itemIdentifier(for: indexPath) else { return }
        coordinator?.showMovieDetail(movieId: movieItem.movie.id)
    }
}
