//
//  PokemonListVC.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 31/08/23.
//

import UIKit
import Combine
import Palette

class PokemonListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonListTable: UITableView!
    
    // MARK: - Variables
    private let viewModel = PokemonListVM()
    private var subscription = Set<AnyCancellable>()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareTableView()
        setupBinding()
        
        viewModel.getPokemons()
    }
    
    // MARK: - Private functions
    /// Configure table view
    private func prepareTableView() {
        let nib = UINib(nibName: "PokemonCell", bundle: nil)
        self.pokemonListTable.register(nib, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
        
        self.pokemonListTable.dataSource = self
        self.pokemonListTable.separatorStyle = .none
    }
    
    
    /// Bind data from data loaded
    private func setupBinding() {
        viewModel
            .$pokemons
            .receive(on: DispatchQueue.main)
            .sink { _ in self.pokemonListTable.reloadData() }
            .store(in: &subscription)
    }
    
    func bind(cell: PokemonCell, to pokemon: Pokemon) {
        cell.pokemonBackgroundView.layer.cornerRadius = 12
        cell.pokemonName.text = pokemon.name?.capitalized
        
        /// One way to load image to UIImageView
//        URLSession.shared
//            .dataTaskPublisher(for: URL(string: WebServiceConstants.getImageURL(from: getIndex(from: currentPokemon.url!)))!)
//            .map { (data, response) in UIImage(data: data)}
//            .replaceError(with: nil)
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.image, on: cell.pokemonImage)
//            .store(in: &(self.subscription))
        
        guard let pokemonURL = pokemon.url else { return }
        
        /// Other way to load image via Combine to UIImageView
        self.viewModel.getPokemonImage(from: pokemonURL, completion: { image in cell.pokemonImage.image = image
            image?.createPalette { palette in
                cell.pokemonBackgroundView.backgroundColor = palette.lightVibrantColor?.withAlphaComponent(0.3)
            }
        })
    }
}


// MARK: - Table View DataSource configuration
extension PokemonListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.reuseIdentifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
        
        let currentPokemon = viewModel.pokemons[indexPath.row]
        self.bind(cell: cell, to: currentPokemon)
        
        /// Paging logic - Loads more data before the last 4th cell shows up to the screen
        if indexPath.row == viewModel.pokemons.count - 4 {
            viewModel.getPokemons()
        }
 
        return cell
    }
}
