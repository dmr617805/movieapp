//
//  ContentView.swift
//  movieapp
//
//  Created by m1 on 01/12/2024.
//


import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = MovieViewModel()
    @State private var searchText = ""
    @State var showingSearchMovie =  false
    
    
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
            .navigationTitle("")
            .toolbar{
                
                ToolbarItem(placement: .navigation) { // Centra el contenido en el título
                          HStack(spacing: 8) {
                              Image(systemName: "popcorn") // Icono de película
                                  .resizable()
                                  .scaledToFit()
                                  .foregroundStyle(Color.red)
                                  .frame(width: 24, height: 24) // Tamaño del icono
                              Text("Palomeras")
                                  .font(.title2)
                                  .foregroundStyle(Color.green)
                                  .bold()
                          }
                      }
                      
                      ToolbarItem(placement: .topBarTrailing) {
                          Button(action: { showingSearchMovie.toggle() }) {
                              Image(systemName: "magnifyingglass.circle")
                          }
                      }
                
                
            }
            .sheet(isPresented: $showingSearchMovie, content: {
                MovieSearchView(isPresented: $showingSearchMovie, viewModel: viewModel)
            })
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
