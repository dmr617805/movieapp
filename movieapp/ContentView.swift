//
//  ContentView.swift
//  movieapp
//
//  Created by m1 on 01/12/2024.
//

import SwiftUI


class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String? = nil
    @Published var genres: [Genre] = []
    @Published var recommendations: [Recommendation] = []
    @Published var selectedMovieSearchType: MovieSearchType?
    
    private let apiService = ApiService()
    
    func fetchMovies(query: String) {
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



struct ContentView: View {
    
    @StateObject private var viewModel = MovieViewModel()
    @State private var query = "rambo"
    @State private var searchText = ""
    
    var filterMovies: [Movie]{
        guard !searchText.isEmpty else {return viewModel.movies}
        return viewModel.movies.filter{ $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                MovieFilterView(viewModel: viewModel)
                
                List(filterMovies, id: \.id) {
                    movie in
                    NavigationLink(destination: MovieDetailView(viewModel: viewModel, movie: movie)){
                        MovieCardView(movie: movie)
                    }
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Películas")
            .searchable(text: $searchText, prompt: "Buscar peliculas")
            .onAppear{
                viewModel.fetchMoviesByType(movieSearchType: .nowPlaying)
                viewModel.fetchGenres()
            }
        }
    }
}

#Preview {
    ContentView()
}
