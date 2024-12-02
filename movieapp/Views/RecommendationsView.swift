//
//  RecommendationsView.swift
//  movieapp
//
//  Created by m1 on 02/12/2024.
//

import SwiftUI

struct RecommendationsView : View {
    let recommendations: [Recommendation]
    
    var body: some View{
        
        Text("Recomendaciones").font(.title2).bold().padding(.bottom)
        
        ScrollView(.horizontal, showsIndicators: true){
            
            HStack(spacing: 10.0){
                ForEach(recommendations, id:\.self.id){
                    recommendation in
                    
                    VStack(alignment: .leading, spacing: 11.0){
                       
                        if let posterPath = recommendation.posterPath{
                            
                            AsyncImage(url: URL(string: Constants.imageUrl + posterPath)) {
                                image in
                                image.image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }.frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 8.0)
                        }else{
                            Image("no-image")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 8.0)
                             
                        }
                        
                        Text(recommendation.title).font(.title3).frame(width: 150, height: 80).lineLimit(3)
                    }
                    
                }
            }
            
        }
        
    }
}
