//
//  Genre.swift
//  movieapp
//
//  Created by m1 on 01/12/2024.
//

import Foundation

// Representa un género individual
struct Genre: Codable {
    let id: Int
    let name: String
}

// Representa la respuesta completa con la lista de géneros
struct GenresResponse: Codable {
    let genres: [Genre]
}
