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
    
    private let backdropImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray5
    }
    
    // 그라디언트 오버레이
    private let gradientView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "arrow_back"), for: .normal)
    }
    
    // 배경 위 영화 정보
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
    
    // 배경 아래 영화 정보 컨테이너
    private let infoContainerView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 20
    }
    
    // 영화 정보
    private let bookingRateView = createInfoHStackView(imageName: "popularity", title: "예매율")
    private let ratingView = createInfoHStackView(imageName: "vote_rate", title: "평점")
    private let runtimeView = createInfoHStackView(imageName: "lucide_clock", title: "상영시간")
    
    // 감독 정보
    private let directorLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .label
        $0.text = "감독"
    }
    
    private let directorNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .label
    }
    
    // 출연진 정보
    private let castLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .label
        $0.text = "출연"
    }
    
    private let castTagListView = CastTagListView()
    
    // 줄거리 정보
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
    
    private let reserveButton = NbcButton(title: "예매하기")
    
    private static func createInfoHStackView(imageName: String, title: String) -> UIView {
        // 컨테이너 내부 HStack
        let hStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 10
        }
        
        // 아이콘
        let iconImageView = UIImageView().then {
            $0.image = UIImage(named: imageName)
            $0.contentMode = .scaleAspectFit
        }
        
        // 텍스트 VStack
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
            $0.tag = 100 // 값 업데이트용 태그
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
        setupGradient()
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
        view.addSubview(reserveButton)
        scrollView.addSubview(contentView)
        
        // 상단 배경
        contentView.addSubview(backdropImageView)
        contentView.addSubview(gradientView)
        contentView.addSubview(backButton)
        contentView.addSubview(movieInfoContainerView)
        contentView.addSubview(favoriteButton)
        
        // 상단 배경 내 영화 정보
        movieInfoContainerView.addSubview(titleLabel)
        movieInfoContainerView.addSubview(subtitleLabel)
        
        // 하단 콘텐츠
        contentView.addSubview(infoContainerView)
        contentView.addSubview(directorLabel)
        contentView.addSubview(directorNameLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(castTagListView)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewContentLabel)
        
        infoContainerView.addArrangedSubview(bookingRateView)
        infoContainerView.addArrangedSubview(ratingView)
        infoContainerView.addArrangedSubview(runtimeView)
        
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
            $0.bottom.equalTo(overviewContentLabel.snp.bottom).offset(100)
        }
        
        backdropImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalTo(backdropImageView)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        movieInfoContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(backdropImageView.snp.bottom).inset(20)
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
            $0.bottom.equalTo(backdropImageView.snp.bottom).inset(20)
            $0.size.equalTo(40)
        }
        
        infoContainerView.snp.makeConstraints {
            $0.top.equalTo(backdropImageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        directorLabel.snp.makeConstraints {
            $0.top.equalTo(infoContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        directorNameLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        castLabel.snp.makeConstraints {
            $0.top.equalTo(directorNameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        castTagListView.snp.makeConstraints {
            $0.top.equalTo(castLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(castTagListView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        overviewContentLabel.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        reserveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    // 배경 내부 그라디언트
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
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        
        favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
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
        
        if let backdropURL = movieDetail.backdropURL {
            backdropImageView.loadImage(from: backdropURL)
        }
        
        titleLabel.text = movieDetail.title
        subtitleLabel.text = "\(movieDetail.releaseDateFormatted) · \(movieDetail.genreNames)"
        
        (bookingRateView.viewWithTag(100) as? UILabel)?.text = String(format: "%.1f%%", movieDetail.bookingRate)
        (ratingView.viewWithTag(100) as? UILabel)?.text = String(format: "%.1f", movieDetail.voteAverage)
        (runtimeView.viewWithTag(100) as? UILabel)?.text = movieDetail.runtimeString
        
        directorNameLabel.text = state.director ?? "정보 없음"
        castTagListView.configure(castList: state.cast)
        
        overviewContentLabel.text = movieDetail.overview.isEmpty ? "줄거리 정보가 없습니다." : movieDetail.overview
        
        // 찜하기 버튼 상태
        favoriteButton.isSelected = state.isFavorite
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        coordinator?.goBack()
    }
    
    @objc private func favoriteButtonTapped() {
        viewModel.action(.favoriteButtonTapped)
    }
    
    @objc private func reserveButtonTapped() {
        guard let movieId = viewModel.currentMovieIdForReservation else {
            return
        }
        coordinator?.showReservation(movieId: movieId)
    }
}
