//
//  SearchViewModel.swift
//  NBCinema
//
//  Created by estelle on 7/21/25.
//

import Foundation

class SearchViewModel: ViewModelProtocol {
    enum Action {
        case loadGenre
        case searchMovie(String)
        case selectGenre(Int)
    }
    
    struct State {
        var genres: [Genre] = []
        var movies: [Movie] = []
        var keyword: String = ""
        var isSearchEmpty: Bool = true
    }
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    private(set) var state: State = .init() {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var onStateChanged: ((State) -> Void)?
    
    func action(_ action: Action) {
        switch action {
            case .loadGenre:
            Task { await fetchGenres() }
            case .searchMovie(let keyword):
            Task { await fetchMovies(keyword) }
        case .selectGenre(let genreId):
            Task { await fetchMoviesByGenre(genreId) }
        }
    }
    
    // 장르 불러오기
    private func fetchGenres() async {
        do {
            let genres = try await repository.fetchGenres()
            state.genres = genres
        } catch {
            print("❌ 장르 로드 실패: \(error)")
        }
    }
    
    // 키워드 기반 영화 검색
    private func fetchMovies(_ keyword: String) async {
        let isEmpty = keyword.trimmingCharacters(in: .whitespaces).isEmpty
        state.isSearchEmpty = isEmpty
        state.movies = []
        state.keyword = keyword
        
        guard !isEmpty else { return }
        
        do {
            let movies = try await repository.searchMovies(query: keyword)
            state.movies = movies
        } catch {
            print("❌ 영화 검색 실패: \(error)")
        }
    }
    
    // 장르 기반 영화 검색
    private func fetchMoviesByGenre(_ genreId: Int) async {
        do {
            state.keyword = state.genres.first(where: { $0.id == genreId })?.name ?? ""
            state.isSearchEmpty = false
            let movies = try await repository.fetchMoviesByGenre(genreId: genreId)
            state.movies = movies
        } catch {
            print("❌ 영화 검색 실패: \(error)")
        }
    }
}
