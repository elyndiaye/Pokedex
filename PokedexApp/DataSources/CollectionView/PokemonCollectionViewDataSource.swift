//
//  pokemonCollectionViewDataSource.swift
//  PokedexApp
//
//  Created by ely.assumpcao.ndiaye on 18/09/19.
//  Copyright © 2019 Ely Assumpcao Ndiaye. All rights reserved.
//

import UIKit

final class PokemonCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    
    let pokemons: [Pokemon]
    
    init(pokemons: [Pokemon], collectionView: UICollectionView){
        self.pokemons = pokemons
        super.init()
        registerCells(in: collectionView)
    }
    
    private func registerCells(in collectionView: UICollectionView) {
        collectionView.register(cellType: PokedexCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PokedexCell.self)
        cell.pokemon = pokemons[indexPath.row]
        let pokemon = pokemons[indexPath.row]
        //cell.setup()
        return cell
    }
    
    
}
