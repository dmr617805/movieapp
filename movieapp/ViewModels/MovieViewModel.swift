//
//  MovieViewModel.swift
//  movieapp
//
//  Created by m1 on 02/12/2024.
//


import SwiftUI


class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String? = nil
    @Published var genres: [Genre] = []
    @Published var recommendations: [Recommendation] = []
    @Published var selectedMovieSearchType: MovieSearchType?
    
    private let apiService = ApiService()
    
    func searchMovies(
        query: String,
        includeAdult: Bool,
        year: String
    ) {
        apiService.searchMovies(query: query, includeAdult: includeAdult, year: year ) {
            result in
            switch result {
            case .success(let moviesresponse):
                DispatchQueue.main.async {
                    self.movies = moviesresponse
                }
            case .failure(let error):
                self.errorMessage =  "ocurrio un error: \(error.localizedDescription)"
            }
        }
    }
    
    func fetchRecommendations(movieId: Int) {
        apiService.getRecommendations(movieId: movieId) {
            result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.recommendations = response
                }
            case .failure(let error):
                self.errorMessage =  "ocurrio un error: \(error.localizedDescription)"
            }
        }
    }
    
    func fetchGenres() {
        apiService.getGenres() {
            result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.genres = response
                }
            case .failure(let error):
                self.errorMessage =  "ocurrio un error: \(error.localizedDescription)"
            }
        }
    }
    
    func fetchMoviesByType(movieSearchType: MovieSearchType){
        selectedMovieSearchType = movieSearchType
        switch movieSearchType {
        case .nowPlaying:
            apiService.getMoviesNowPlaying() {
                result in
                switch result {
                case .success(let moviesresponse):
                    DispatchQueue.main.async {
                        self.movies = moviesresponse
                    }
                case .failure(let error):
                    self.errorMessage =  "ocurrio un error: \(error.localizedDescription)"
                }
            }
        case .popular:
            apiService.getMoviesPopular() {
                result in
                switch result {
                case .success(let moviesresponse):
                    DispatchQueue.main.async {
                        self.movies = moviesresponse
                    }
                case .failure(let error):
                    self.errorMessage =  "ocurrio un error: \(error.localizedDescription)"
                }
            }
        case .topRated:
            apiService.getMoviesTopRated() {
                result in
                switch result {
                case .success(let moviesresponse):
                    DispatchQueue.main.async {
                        self.movies = moviesresponse
                    }
                case .failure(let error):
                    self.errorMessage =  "ocurrio un error: \(error.localizedDescription)"
                }
            }
            
        case .upcoming:
            apiService.getMoviesUpcoming() {
                result in
                switch result {
                case .success(let moviesresponse):
                    DispatchQueue.main.async {
                        self.movies = moviesresponse
                    }
                case .failure(let error):
                    self.errorMessage =  "ocurrio un error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    
    
}
