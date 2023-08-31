//
//  WebService.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 31/08/23.
//

import Foundation
import Combine
import UIKit

/// Customized errors thrown by networking
enum WebServiceError : LocalizedError {
    case invalidURL
    case invalidData
    case errorWhileParsing
    
    var errorDescription: String? {
        switch self {
            case .invalidURL: return "URL provided is not valid"
            case .invalidData: return "Malformed data while getting response"
            case .errorWhileParsing: return "Malformed JSON data while parsing"
        }
    }
}

/// Constants to user with Web Services
struct WebServiceConstants {
    static let pokemonInitialURL = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
    
    static func getImageURL(from index: String) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(index).png"
    }
}

/// Web service manager for generic services
class WebServiceManager {
    static let shared = WebServiceManager()
    
    func getData<T: Codable>(from url: String) -> AnyPublisher<T?, WebServiceError> {
        guard let request = URL(string: url) else { return Fail(error: WebServiceError.invalidURL).eraseToAnyPublisher() }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.0 }
            .decode(type: T?.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: WebServiceError.errorWhileParsing).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
    
    func getImage(from url: String) -> AnyPublisher<UIImage?, WebServiceError> {
        guard let request = URL(string: url) else { return Fail(error: WebServiceError.invalidURL).eraseToAnyPublisher() }
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { (data, response) in UIImage(data: data) }
            .catch { _ in Fail(error: WebServiceError.invalidData).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}
