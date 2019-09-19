//
//  PokedexController.swift
//  PokedexApp
//
//  Created by Ely Assumpcao Ndiaye on 01/09/2019.
//  Copyright © 2019 Ely Assumpcao Ndiaye. All rights reserved.
//

import UIKit


class PokedexController: UICollectionViewController{
    
    //MARK - Properties
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    
    var collectionViewDataSource: PokemonCollectionViewDataSource?
    var collectionViewDelegate: PokemonCollectionViewDelegate?
    
//    let infoView: InfoView = {
//        let view = InfoView()
//        view.layer.cornerRadius = 5
//        return view
//    }()
//    
//    let visualEffectView: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .dark)
//        let view = UIVisualEffectView(effect: blurEffect)
//        return view
//    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: PokedexCell.self)
        configureViewComponents()
        fetchPokemon()
        
    }
    
    //Mark: - Selectors
    @objc func showSearchBar(){
        print(123)
    }
    
    // MARK: - API
    func fetchPokemon() {
        Service.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                //self.collectionView.reloadData()
                self.setupCollectionView(width: pokemon)
            }
        }
    }
    
    //MARK: - SetupCollectionView
    func setupCollectionView(width pokemons: [Pokemon]){
        collectionViewDataSource = PokemonCollectionViewDataSource(pokemons: pokemons, collectionView: collectionView)
        collectionViewDelegate = PokemonCollectionViewDelegate()
        
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.reloadData()
        
    }
    
    
    //MARK: - HELPER FUNCTIONS
    func configureViewComponents(){
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .mainPink()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Pokedex"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        
    }
}

extension PokedexController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PokedexCell.self)
        cell.pokemon = pokemon[indexPath.row]
        
        return cell
    }
}

extension PokedexController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
}
