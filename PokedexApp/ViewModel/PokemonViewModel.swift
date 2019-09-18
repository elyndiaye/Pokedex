//
//  PokemonViewModel.swift
//  PokedexApp
//
//  Created by ely.assumpcao.ndiaye on 17/09/19.
//  Copyright © 2019 Ely Assumpcao Ndiaye. All rights reserved.
//

import UIKit


struct PokemonViewModel {
    
    var name: String?
    var imageUrl: String?
    var image: UIImage?
    var id: Int?
    var weight: Int?
    var height: Int?
    var defense: Int?
    var attack: Int?
    var description: String?
    var type: String?
    var evolutionChain: [[String: AnyObject]]?
    var evoArray: [Pokemon]?
    
    var pokemon: Pokemon?
    
    init(pokemon: Pokemon) {
        
        self.name = pokemon.name
        guard let image = pokemon.image else { return }
        self.image = image
        guard let type = pokemon.type else { return }
        self.type = type
        guard let defense = pokemon.defense else { return }
        self.defense = defense
        guard let attack = pokemon.attack else { return }
        self.attack = attack
        guard let id = pokemon.id else { return }
        self.id = id
        guard let height = pokemon.height else { return }
        self.height = height
        guard let weight = pokemon.weight else { return }
        self.weight = weight
        guard let evolutionChain = pokemon.evolutionChain else { return }
        self.evolutionChain = evolutionChain
        guard let evoArray = pokemon.evoArray else { return }
        self.evoArray = evoArray
        
    }
    
}
