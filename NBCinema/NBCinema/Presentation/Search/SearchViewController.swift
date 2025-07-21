//
//  SearchViewController.swift
//  NBCinema
//
//  Created by estelle on 7/20/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    weak var coordinator: SearchCoordinator?
    private let searchView = SearchView()
    let viewModel: SearchViewModel
    var typingTimer: Timer?     // 검색 지연 타이머
    
    init(repository: MovieRepository) {
        self.viewModel = SearchViewModel(repository: repository)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.action(.loadGenre)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        searchView.searchBar.delegate = self
        searchView.genreTagView.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        
        bindViewModel()
        setupKeyboardDismissGesture()
    }
    
    // ViewModel의 상태 바인딩
    private func bindViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.searchView.configure(state)
                self?.searchView.collectionView.reloadData()
            }
        }
    }
    
    // 키보드 닫기 제스처
    private func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // 컬렉션뷰 셀 클릭 등 다른 터치 방해 방지
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
