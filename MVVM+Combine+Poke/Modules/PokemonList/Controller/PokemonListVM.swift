//
//  PokemonListVM.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 31/08/23.
//

import Foundation
import Combine
import UIKit

class PokemonListVM {
    // MARK: - Variables
    private var subscriptions = Set<AnyCancellable>()
    
    @Published private(set) var pokemons: Pokemons = []
    
    var numberOfRows: Int {
        pokemons.count
    }
    
    /// Fetches pokemon from Web Service
    func getPokemons() {
        PokeWebService.shared.getPokemons()
            .sink(receiveCompletion: { _ in print("Pokemon fetching completion is called")}, receiveValue: { [weak self] pokemonsOptional in
                guard let pokemons = pokemonsOptional else { return }
                self?.pokemons.append(contentsOf: pokemons)
            })
            .store(in: &subscriptions)
    }
    
    /// Load pokemon image from URL
    func getPokemonImage(from id: String, completion: @escaping (UIImage?) -> Void) {
        PokeWebService.shared
            .getPokemonImage(from: WebServiceConstants.getImageURL(from: id))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in print("Image fetching completion is called")},
                receiveValue: completion
            )
            .store(in: &subscriptions)
    }
}
