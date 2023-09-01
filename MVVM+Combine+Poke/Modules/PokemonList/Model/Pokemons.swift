//
//  Pokemons.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 31/08/23.
//

import Foundation

// MARK: - PokeAPIResponse
struct PokeAPIResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Pokemon]?
}

// MARK: - Result
struct Pokemon: Codable {
    let name: String?
    let url: String?
    
    var id: String? {
        if let pokemonURL = url {
            let stringArray = pokemonURL.components(separatedBy: "/")
            return stringArray[stringArray.count - 2]
        } else {
            return nil
        }
    }
}

typealias Pokemons = [Pokemon]
