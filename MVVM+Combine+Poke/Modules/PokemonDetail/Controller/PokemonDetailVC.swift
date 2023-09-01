//
//  PokemonDetailVC.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 01/09/23.
//

import UIKit
import Combine
import Palette
//import MultiProgressView

class PokemonDetailVC: UIViewController {
    
    // MARK: - Constants
    static let segueIdentifier = "PokemonDetail"

    // MARK: - Outlets
    @IBOutlet weak var pokemonDetailScrollView: UIScrollView!
    @IBOutlet weak var pokemonDetailBackgroundView: UIView!
    @IBOutlet weak var pokemonNameLable: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonProfileBackground: UIView!
    @IBOutlet weak var pokemonTypeCollectionView: UICollectionView!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var hpProgressView: UIProgressView!
    @IBOutlet weak var atkProgressView: UIProgressView!
    @IBOutlet weak var expProgressView: UIProgressView!
    @IBOutlet weak var spdProgressView: UIProgressView!
    @IBOutlet weak var defProgressView: UIProgressView!
    
    // MARK: - Variables
    let viewModel = PokemonDetailVM()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setUpBinding()
    }
    
    // MARK: - Private functions
    /// Setup UI
    private func configureUI() {
        self.pokemonProfileBackground.layer.cornerRadius = 24
        self.pokemonDetailBackgroundView.backgroundColor = UIColor(rgb: 0x2B292B)
        
        self.pokemonImage.image = self.viewModel.pokemonImage
        self.pokemonProfileBackground.backgroundColor = self.viewModel.vibrantColorFromImage?.withAlphaComponent(0.4)
        
        prepareCollectionView()
    }
    
    /// Prepare collection view to set up pokemon types with custom configurations
    private func prepareCollectionView() {
        self.pokemonTypeCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: (self.view.frame.width / 3), height: 40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.pokemonTypeCollectionView.collectionViewLayout = layout
        self.pokemonTypeCollectionView.backgroundColor = nil
    }
    
    
    /// Bind data to views
    private func setUpBinding() {
        viewModel
            .$pokemonDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemon in
                self?.pokemonTypeCollectionView.reloadData()
                self?.pokemonNameLable.text = pokemon?.name?.capitalized
                self?.pokemonIdLabel.text = self?.getIdLabelText(from: String(pokemon?.id ?? 0))
                self?.pokemonWeightLabel.text = pokemon?.roundedWeightString
                self?.pokemonHeightLabel.text = pokemon?.roundedHeightString
                
                self?.hpProgressView.progress = pokemon?.hp ?? 0
                self?.atkProgressView.progress = pokemon?.attack ?? 0
                self?.defProgressView.progress = pokemon?.defence ?? 0
                self?.expProgressView.progress = pokemon?.exp ?? 0
                self?.spdProgressView.progress = pokemon?.speed ?? 0
                
                self?.hpProgressView.increaseSizeBy()
                self?.atkProgressView.increaseSizeBy()
                self?.defProgressView.increaseSizeBy()
                self?.expProgressView.increaseSizeBy()
                self?.spdProgressView.increaseSizeBy()
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

// MARK: - PokemonType DataSource
extension PokemonDetailVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemonDetail?.types?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonTypeCell", for: indexPath) as? PokemonTypeCell else { return UICollectionViewCell() }
        
        let type = viewModel.pokemonDetail?.types?[indexPath.row].type
        cell.pokemonTypeLabel.text = type?.name?.capitalized
        cell.pokemonTypeBackground.layer.cornerRadius = 12
        cell.pokemonTypeBackground.backgroundColor = type?.typeBackgroundColor
        
        return cell
    }
}
