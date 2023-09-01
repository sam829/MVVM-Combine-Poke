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
    @Published private(set) var pokemonDetali: PokemonDetail?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    /// Fetch pokemon detail from the id
    func getPokemonDetail(from id: String) {
        PokeWebService.shared
            .getPokemonDetail(of: id)
            .sink(
                receiveCompletion: { _ in print("Pokemon detail completion for \(id)")},
                receiveValue: { [weak self] pokemonDetail in
                    self?.pokemonDetali = pokemonDetail
                }
            )
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
