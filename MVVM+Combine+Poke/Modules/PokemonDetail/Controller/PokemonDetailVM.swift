//
//  PokemonDetailVM.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 01/09/23.
//

import Foundation
import Combine
import UIKit

class PokemonDetailVM {
    // MARK: - Variables
    @Published private(set) var pokemonDetail: PokemonDetail?
    private(set) var vibrantColorFromImage: UIColor?
    private(set) var pokemonImage: UIImage?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    // MARK: - Functions
    /// Fetch pokemon detail from the id
    func getPokemonDetail(from id: String) {
        PokeWebService.shared
            .getPokemonDetail(of: id)
            .sink(
                receiveCompletion: { _ in print("Pokemon detail completion for \(id)")},
                receiveValue: { [weak self] pokemonDetail in
                    self?.pokemonDetail = pokemonDetail
                }
            )
            .store(in: &subscriptions)
    }
    
    // MARK: - Setters
    func updateVibrantColor(color: UIColor?) {
        self.vibrantColorFromImage = color
    }
    
    func updatePokemonImage(with image: UIImage?) {
        self.pokemonImage = image
    }
}
