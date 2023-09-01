//
//  PokeWebService.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 31/08/23.
//

import Foundation
import Combine
import UIKit

class PokeWebService {
    static let shared = PokeWebService()
    
    private var nextPage: String?
    
    func getPokemons() -> AnyPublisher<Pokemons?, WebServiceError>  {
        var url: String
        if nextPage == nil {
            url = WebServiceConstants.pokemonInitialURL
        } else {
            url = nextPage!
        }
        
        let pokeResponsePublisher: AnyPublisher<PokeAPIResponse?, WebServiceError> = WebServiceManager.shared.getData(from: url)
        
        return pokeResponsePublisher
            .print("fetching pokemons")
            .map { [weak self] response in
                self?.nextPage = response?.next
                return response?.results
            }
            .eraseToAnyPublisher()
    }
    
    func getPokemonImage(from url: String) -> AnyPublisher<UIImage?, WebServiceError> {
        return WebServiceManager.shared.getImage(from: url)
    }
    
    func getPokemonDetail(of id: String) -> AnyPublisher<PokemonDetail?, WebServiceError> {
        let pokemonDetailResponsePublisher: AnyPublisher<PokemonDetail?, WebServiceError> = WebServiceManager.shared.getData(from: WebServiceConstants.getPokemonDetailURL(for: id))
        
        return pokemonDetailResponsePublisher
            .print("fetching details of pokemon \(id)")
            .eraseToAnyPublisher()
    }
}
