//
//  MoviewSearchTypeView.swift
//  movieapp
//
//  Created by m1 on 01/12/2024.
//

import SwiftUI

struct MovieFilterView: View {
    @ObservedObject var viewModel: MovieViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 15) {
                ForEach(MovieSearchType.allCases, id: \.self ){
                    movieSearchType in
                    MovieFilterButton(movieSearchType: movieSearchType, isSelected: viewModel.selectedMovieSearchType == movieSearchType, action:{
                        viewModel.fetchMoviesByType(movieSearchType: movieSearchType)
                    })
                }
            }.padding()
        }
    }
}


struct MovieFilterButton: View {
    let movieSearchType: MovieSearchType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action:action){
            VStack{
                Image(systemName: movieSearchType.icon)
                    .font(.system(size: 24))
                Text(movieSearchType.rawValue)
                    .font(.caption)
            }
        }
        .padding()
        .frame(width: 110)
        .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
        .foregroundStyle(isSelected ? .blue : .primary)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
