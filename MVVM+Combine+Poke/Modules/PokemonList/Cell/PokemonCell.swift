//
//  PokemonCell.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 31/08/23.
//

import UIKit

class PokemonCell: UITableViewCell {
    // MARK: - Constants
    static let reuseIdentifier = "Pokemon"
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonBackgroundView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
