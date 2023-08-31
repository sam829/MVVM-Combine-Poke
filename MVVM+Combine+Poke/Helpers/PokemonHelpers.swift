//
//  PokemonHelpers.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 31/08/23.
//

import Foundation

/// Get Pokemon id from url
func getPokemonId(from url: String) -> String {
    let stringArray = url.components(separatedBy: "/")
    return stringArray[stringArray.count - 2]
}
