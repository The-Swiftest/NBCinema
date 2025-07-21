//
//  SearchViewController+Extention.swift
//  NBCinema
//
//  Created by estelle on 7/21/25.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        typingTimer?.invalidate()
        // 1초 후 검색 요청
        typingTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.viewModel.action(.searchMovie(searchText))
        }
    }
    
    // 검색 버튼 누르면 키보드 닫기
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: GenreTagListViewDelegate {
    func didSelectGenre(_ id: Int) {
        viewModel.action(.selectGenre(id))
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = viewModel.state.movies[indexPath.row].id
        coordinator?.showMovieDetail(movieId: movieId)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.state.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviePosterCell", for: indexPath) as? MoviePosterCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.state.movies[indexPath.item]
        cell.configure(movie: movie)
        return cell
    }
    
    // 헤더 뷰 구성
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        // 헤더 타입일 때만 처리
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        // 헤더 뷰 재사용
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SearchSectionHeaderView.reuseIdentifier,
            for: indexPath
        ) as! SearchSectionHeaderView
        
        // 헤더 텍스트 설정
        header.configure(title: "총 \(viewModel.state.movies.count)개의 영화")
        return header
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    // 헤더 높이 지정
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        let height = 30.0
        
        return .init(width: width, height: height)
    }
}
