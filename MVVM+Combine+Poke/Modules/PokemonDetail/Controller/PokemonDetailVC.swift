//
//  PokemonDetailVC.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 01/09/23.
//

import UIKit
import Combine
import Palette

class PokemonDetailVC: UIViewController {
    
    static let segueIdentifier = "PokemonDetail"

    @IBOutlet weak var pokemonDetailScrollView: UIScrollView!
    @IBOutlet weak var pokemonDetailBackgroundView: UIView!
    @IBOutlet weak var pokemonNameLable: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonProfileBackground: UIView!
    
    let viewModel = PokemonDetailVM()
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setUpBinding()
    }
    
    private func configureUI() {
        pokemonProfileBackground.layer.cornerRadius = 24
        pokemonDetailBackgroundView.backgroundColor = .gray.withAlphaComponent(0.7)
    }
    
    private func setUpBinding() {
        viewModel
            .$pokemonDetali
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemon in
                self?.pokemonNameLable.text = pokemon?.name?.capitalized
                self?.pokemonIdLabel.text = self?.getIdLabelText(from: String(pokemon?.id ?? 0))
//                self?.pokemonTypeLabel.text = pokemon?.types?[0].type?.name?.capitalized
                self?.viewModel
                    .getPokemonImage(
                        from: String(pokemon?.id ?? 0),
                        completion: { image in
                            self?.pokemonImage.image = image
                            image?.createPalette { palette in
                                self?.pokemonProfileBackground.backgroundColor = palette.lightVibrantColor?.withAlphaComponent(0.4)
                            }
                        }
                    )
            }
            .store(in: &subscriptions)
    }
    
    private func getIdLabelText(from id: String) -> String {
        if id.count == 2 {
            return "#0\(id)"
        } else if id.count == 1 {
            return "#00\(id)"
        } else {
            return "#\(id)"
        }
    }
}
