//
//  MovieCardView.swift
//  movieapp
//
//  Created by m1 on 02/12/2024.
//

import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    let imageUrl: String = "https://media.themoviedb.org/t/p/w220_and_h330_face"
    
    var body: some View {
        VStack(alignment: .center, spacing: 50){
            ZStack{
                
                if let posterPath = movie.posterPath{
                    
                    AsyncImage(url: URL(string: imageUrl + posterPath)) {
                        image in
                        image.image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }.frame(height: 500)
                        .clipped()
                       
                }else{
                     Image("no-image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 500)
                }
                
                
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
                .offset(x:-100, y: 250)
                
                
            }
          
            VStack(alignment: .center, spacing: 12.0){
                
                Text(movie.title)
                    .font(.title)
                    .bold()
              
                
                Text(movie.releaseDate)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }.padding()
    

        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 8.0)
     
    }
    
    
}


#Preview {
    
    let movie = Movie(adult: true, backdropPath: "", genreIDs: [10], id: 10, originalLanguage: "", originalTitle: "Venom: The Last Dance", overview: "Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie's last dance.", popularity: 10, posterPath:"/aosm8NMQ3UyoBVpSxyimorCQykC.jpg", releaseDate: "2024-10-22", title: "Venom: The Last Dance", video: false, voteAverage: 6.443, voteCount: 964
    
    )
    MovieCardView(movie: movie)
}
