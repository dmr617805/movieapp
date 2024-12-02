//
//  MovieSearchType.swift
//  movieapp
//
//  Created by m1 on 01/12/2024.
//

enum MovieSearchType: String, CaseIterable {
    case nowPlaying = "En cartelera"
    case popular = "Popular"
    case topRated = "Mejor Calificado"
    case upcoming = "Proximas"
    
    var icon: String {
        switch self {
            case .nowPlaying: return "theatermasks.circle"
            case .popular: return "person.3"
            case .topRated: return "medal.star"
            case .upcoming: return "bell.and.waves.left.and.right"
        }
    }
}
