//
//  MovieDetailView.swift
//  movieapp
//
//  Created by m1 on 02/12/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieViewModel
    let movie: Movie
    let imageUrl: String = "https://media.themoviedb.org/t/p/w220_and_h330_face"
    
    var body: some View {
        ScrollView{
            
            VStack(spacing: 4.0){
                
                if let posterPath = movie.posterPath{
                    
                    AsyncImage(url: URL(string: imageUrl + posterPath)) {
                        image in
                        image.image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }.frame(height: 500)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 8.0)
                    
                    
                }else{
                    Image("no-image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 500)
                }
                
                
                HStack(spacing: 4.0){
                    
                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                        Text(String(format: "%.1f", movie.voteAverage))
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black))
                    .frame(height: 100).frame(width: 100)
                    
                }
                
                
                HStack {
                    ForEach(movie.genreIDs, id: \.self) { genreId in
                        if let genreName = viewModel.genres.first(where: { $0.id == genreId })?.name {
                            Text(genreName)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .font(.caption)
                        }
                    }
                }.padding(.vertical)
                
                
                VStack(alignment: .leading)
                {
                    Text("Resumen").font(.title2).bold().padding(.bottom)
                    Text(movie.overview).font(.headline)
                }
                
                Text("Recomendaciones").font(.title2).bold().padding(.bottom)
                HStack{
                    ForEach(viewModel.recommendtions, id:\.self.id){
                        recommendation in
                        Text(recommendation.title)
                    }
                }
                
                
                
                
            }.padding()
        }.onAppear{
            viewModel.fetchRecommendations(movieId: movie.id)
        }
    }
}



#Preview {
    let viewModel = MovieViewModel()
    let movie = Movie(adult: true, backdropPath: "", genreIDs: [10], id: 10, originalLanguage: "", originalTitle: "Venom: The Last Dance", overview: "Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie's last dance.", popularity: 10, posterPath:"/aosm8NMQ3UyoBVpSxyimorCQykC.jpg", releaseDate: "2024-10-22", title: "Venom: The Last Dance", video: false, voteAverage: 6.443, voteCount: 964
                      
    )
    MovieDetailView(viewModel: viewModel, movie: movie)
}
