//
//  PokemonDetail.swift
//  MVVM+Combine+Poke
//
//  Created by Saumya Macwan on 01/09/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonDetail = try? JSONDecoder().decode(PokemonDetail.self, from: jsonData)

import UIKit

// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let forms: [Species]?
    let gameIndices: [GameIndex]?
    let height: Double?
    let heldItems: [HeldItem]?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let pastTypes: [PastType]?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Double?
    
    var roundedWeightString: String {
        return "\(Double(round(1000 * (self.weight ?? 0)) / 1000)) KG"
    }
    
    var roundedHeightString: String {
        return "\(Double(round(1000 * (self.height ?? 0)) / 1000)) M"
    }
    
    var hp: Float {
        return Float.random(in: 0..<1)
    }
    
    var attack: Float {
        return Float.random(in: 0..<1)
    }
    
    var defence: Float {
        return Float.random(in: 0..<1)
    }
    
    var speed: Float {
        return Float.random(in: 0..<1)
    }
    
    var exp: Float {
        return Float.random(in: 0..<1)
    }

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case forms
        case gameIndices = "game_indices"
        case height
        case heldItems = "held_items"
        case id
        case isDefault = "is_default"
        case locationAreaEncounters = "location_area_encounters"
        case moves, name, order
        case pastTypes = "past_types"
        case species, sprites, stats, types, weight
    }
}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
    
    var typeBackgroundColor: UIColor {
        switch(self.name) {
            case "fighting" : return UIColor(rgb: 0x9F422A)
            case "flying" : return UIColor(rgb: 0x90B1C5)
            case "poison" : return UIColor(rgb: 0x642785)
            case "ground" : return UIColor(rgb: 0xAD7235)
            case "rock" : return UIColor(rgb: 0x4B190E)
            case "bug" : return UIColor(rgb: 0x179A55)
            case "ghost" : return UIColor(rgb: 0x363069)
            case "steel" : return UIColor(rgb: 0x5C756D)
            case "fire" : return UIColor(rgb: 0xB22328)
            case "water" : return UIColor(rgb: 0x2648DC)
            case "grass" : return UIColor(rgb: 0x007C42)
            case "electric" : return UIColor(rgb: 0xE0E64B)
            case "psychic" : return UIColor(rgb: 0xAC296B)
            case "ice" : return UIColor(rgb: 0x7ECFF2)
            case "dragon" : return UIColor(rgb: 0x378A94)
            case "fairy" : return UIColor(rgb: 0x9E1A44)
            case "dark" : return UIColor(rgb: 0x040706)
            default : return UIColor(rgb: 0xB1A5A5)
        }
    }
}

// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int?
    let version: Species?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - HeldItem
struct HeldItem: Codable {
    let item: Species?
    let versionDetails: [VersionDetail]?

    enum CodingKeys: String, CodingKey {
        case item
        case versionDetails = "version_details"
    }
}

// MARK: - VersionDetail
struct VersionDetail: Codable {
    let rarity: Int?
    let version: Species?
}

// MARK: - Move
struct Move: Codable {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: Species?

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - GenerationV
struct GenerationV: Codable {
    let blackWhite: Sprites?

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

// MARK: - GenerationIv
struct GenerationIv: Codable {
    let diamondPearl, heartgoldSoulsilver, platinum: Sprites?

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

// MARK: - Versions
struct Versions: Codable {
    let generationI: GenerationI?
    let generationIi: GenerationIi?
    let generationIii: GenerationIii?
    let generationIv: GenerationIv?
    let generationV: GenerationV?
    let generationVi: [String: Home]?
    let generationVii: GenerationVii?
    let generationViii: GenerationViii?

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault, backFemale, backShiny, backShinyFemale: String?
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?
    let other: Other?
    let versions: Versions?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other, versions, animated
    }

    init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?, other: Other?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
        self.versions = versions
        self.animated = animated
    }
}

// MARK: - GenerationI
struct GenerationI: Codable {
    let redBlue, yellow: RedBlue?

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

// MARK: - RedBlue
struct RedBlue: Codable {
    let backDefault, backGray, backTransparent, frontDefault: String?
    let frontGray, frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backGray = "back_gray"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - GenerationIi
struct GenerationIi: Codable {
    let crystal: Crystal?
    let gold, silver: Gold?
}

// MARK: - Crystal
struct Crystal: Codable {
    let backDefault, backShiny, backShinyTransparent, backTransparent: String?
    let frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backShinyTransparent = "back_shiny_transparent"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontShinyTransparent = "front_shiny_transparent"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - Gold
struct Gold: Codable {
    let backDefault, backShiny, frontDefault, frontShiny: String?
    let frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - GenerationIii
struct GenerationIii: Codable {
    let emerald: OfficialArtwork?
    let fireredLeafgreen, rubySapphire: Gold?

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Home
struct Home: Codable {
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - GenerationVii
struct GenerationVii: Codable {
    let icons: DreamWorld?
    let ultraSunUltraMoon: Home?

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    let frontDefault: String?
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - GenerationViii
struct GenerationViii: Codable {
    let icons: DreamWorld?
}

// MARK: - Other
struct Other: Codable {
    let dreamWorld: DreamWorld?
    let home: Home?
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: Species?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

//enum PokemonStats: Int, CaseIterable {
//    case hp, attack, defence, speed, exp
//
//    var section: Int {
//        switch self {
//            case .hp: return 0
//            case .attack: return 1
//            case .defence: return 2
//            case .speed: return 3
//            case .exp: return 4
//        }
//    }
//
//    var stateFromSection: PokemonStats {
//        switch self.rawValue {
//            case 0: return .hp
//            case 1: return .attack
//            case 2: return .defence
//            case 3: return .speed
//            case 4: return .exp
//            default: return .hp
//        }
//    }
//
//    var color: UIColor {
//        switch self {
//        case .hp:
//            return .black
//        case .attack:
//            return .blue
//        case .defence:
//            return .yellow
//        case .speed:
//            return .cyan
//        case .exp:
//            return .brown
//        }
//    }
//
//    var description: String {
//        switch self {
//        case .hp:
//            return "HP"
//        case .attack:
//            return "ATK"
//        case .defence:
//            return "DFNC"
//        case .speed:
//            return "SPD"
//        case .exp:
//            return "EXP"
//        }
//    }
//}

// MARK: - PastType
struct PastType: Codable {
    let generation: Species?
    let types: [TypeElement]?
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: Species?
}
