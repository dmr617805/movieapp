//
//  MovieResponse.swift
//  movieapp
//
//  Created by m1 on 01/12/2024.
//


import Foundation

// Struct principal para manejar la respuesta completa
struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
