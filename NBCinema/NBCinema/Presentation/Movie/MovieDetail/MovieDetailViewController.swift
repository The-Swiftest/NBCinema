//
//  MovieDetailViewController.swift
//  NBCinema
//
//  Created by Milou on 7/21/25.
//

import UIKit
import SnapKit
import Then

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: MovieDetailViewModel
    private weak var coordinator: MovieDetailCoordinator?
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .systemBackground
        $0.showsVerticalScrollIndicator = true
    }
    
    private let contentView = UIView()
    
    private let headerView = MovieDetailHeaderView()
    private let statsView = MovieInfoStatsView()
    private let contentDetailView = MovieDetailContentView()
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "arrow_back"), for: .normal)
    }
    
    private let reserveButton = NbcButton(title: "예매하기")
    
    // MARK: - Initializer
    
    init(viewModel: MovieDetailViewModel, coordinator: MovieDetailCoordinator) {
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
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        view.addSubview(backButton)
        view.addSubview(reserveButton)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerView)
        contentView.addSubview(statsView)
        contentView.addSubview(contentDetailView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        statsView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        contentDetailView.snp.makeConstraints {
            $0.top.equalTo(statsView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(100)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
        
        reserveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func setupActions() {
        headerView.delegate = self
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        reserveButton.addTarget(
            self,
            action: #selector(reserveButtonTapped),
            for: .touchUpInside
        )
    }
    
    func loadMovieDetail(movieId: Int) {
        viewModel.action(.fetchMovieDetail(movieId: movieId))
    }
    
    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.updateUI(with: state)
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.coordinator?.showError(error)
            }
        }
    }
    
    private func updateUI(with state: MovieDetailViewModel.State) {
        guard let movieDetail = state.movieDetail else { return }
        
        // Header 업데이트
        headerView.configure(
            title: movieDetail.title,
            subtitle: "\(movieDetail.releaseDateFormatted) · \(movieDetail.genreNames)",
            backdropURL: movieDetail.backdropURL,
            isFavorite: state.isFavorite
        )
        
        // Stats 업데이트
        statsView.configure(
            bookingRate: movieDetail.bookingRate,
            rating: movieDetail.voteAverage,
            runtime: movieDetail.runtimeString
        )
        
        // Content 업데이트
        contentDetailView.configure(
            director: state.director,
            cast: state.cast,
            overview: movieDetail.overview
        )
    }
    
    // MARK: - Actions
    
    @objc
    private func backButtonTapped() {
            coordinator?.goBack()
        }
    
    @objc
    private func reserveButtonTapped() {
        guard let movieId = viewModel.currentMovieIdForReservation else { return }
        coordinator?.showReservation(movieId: movieId)
    }
}

// MARK: - MovieDetailHeaderViewDelegate

extension MovieDetailViewController: MovieDetailHeaderViewDelegate {
    
    func headerViewFavoriteButtonTapped() {
        viewModel.action(.favoriteButtonTapped)
    }
}
