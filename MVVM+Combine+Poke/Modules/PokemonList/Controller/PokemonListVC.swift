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
        
        configureUI()
        setupBinding()
        
        viewModel.getPokemons()
    }
    
    // MARK: - Private functions
    /// Set up view configuration
    private func configureUI() {
        self.view.backgroundColor = UIColor(rgb: 0x2B292B)
        
        self.navigationItem.title = "Pokemons"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        prepareTableView()
    }
    
    /// Configure table view
    private func prepareTableView() {
        let nib = UINib(nibName: "PokemonCell", bundle: nil)
        self.pokemonListTable.register(nib, forCellReuseIdentifier: PokemonCell.reuseIdentifier)
        
        self.pokemonListTable.dataSource = self
        self.pokemonListTable.delegate = self
        self.pokemonListTable.separatorStyle = .none
        self.pokemonListTable.backgroundColor = UIColor(rgb: 0x2B292B)
    }
    
    
    /// Bind data from data loaded
    private func setupBinding() {
        viewModel
            .$pokemons
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.pokemonListTable.reloadData()
            }
            .store(in: &subscription)
    }
    
    func bind(cell: PokemonCell, to pokemon: Pokemon) {
        cell.pokemonBackgroundView.layer.cornerRadius = 12
        cell.pokemonName.text = pokemon.name?.capitalized
        cell.backgroundColor = UIColor(rgb: 0x2B292B)
        cell.selectionStyle = .none
        
        guard let pokemonId = pokemon.id else { return }
//        let pokemonId = getPokemonId(from: pokemonURL)
//        guard let imageDownloadRequest = URL(string: WebServiceConstants.getImageURL(from: pokemonId)) else { return }
        
        /// One way to load image to UIImageView
//        URLSession.shared
//            .dataTaskPublisher(for: imageDownloadRequest)
//            .map { (data, response) in
//                let image = UIImage(data: data)
//                image?.createPalette { palette in DispatchQueue.main.async { cell.pokemonBackgroundView.backgroundColor = palette.lightVibrantColor?.withAlphaComponent(0.3) } }
//                return image
//            }
//            .replaceError(with: nil)
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.image, on: cell.pokemonImage)
//            .store(in: &(self.subscription))
        
        /// Other way to load image via Combine to UIImageView
        self.viewModel.getPokemonImage(from: pokemonId, completion: { image in cell.pokemonImage.image = image
            image?.createPalette { palette in
                cell.pokemonBackgroundView.backgroundColor = palette.lightVibrantColor?.withAlphaComponent(0.3)
            }
        })
    }
}


// MARK: - Table View DataSource configuration
extension PokemonListVC: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let pokemonDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "PokemonDetailVC") as? PokemonDetailVC {
            if let cell = tableView.cellForRow(at: indexPath) as? PokemonCell {
                pokemonDetailVC.viewModel.updateVibrantColor(color: cell.pokemonBackgroundView.backgroundColor)
                pokemonDetailVC.viewModel.updatePokemonImage(with: cell.pokemonImage.image)
            }
        
            if let pokemonId = self.viewModel.pokemons[indexPath.row].id {
                pokemonDetailVC.viewModel.getPokemonDetail(from:pokemonId)
            }
            
            self.present(pokemonDetailVC, animated: true)
        }
    }
}
