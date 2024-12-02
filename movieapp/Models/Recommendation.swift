//
//  Recommendation.swift
//  movieapp
//
//  Created by m1 on 02/12/2024.
//

import Foundation

struct Recommendation: Codable, Identifiable {
    let id: Int
    let backdropPath: String?
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let mediaType: String
    let adult: Bool
    let originalLanguage: String
    let genreIds: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIds = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}



struct RecommendationResponse: Codable {
    let page: Int
    let results: [Recommendation]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
