//
//  PokemonCollectionViewDelegate.swift
//  PokedexApp
//
//  Created by ely.assumpcao.ndiaye on 18/09/19.
//  Copyright © 2019 Ely Assumpcao Ndiaye. All rights reserved.
//

import UIKit

final class PokemonCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.size.width - 36) / 3
        return CGSize(width: width, height: width)
    }
}
