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
    
    let infoView: InfoView = {
        let view = InfoView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: PokedexCell.self)
        configureViewComponents()
        fetchPokemon()
        
    }
    
    //Mark: - Selectors
    @objc func showSearchBar(){
        configureSearchBar(shouldShow: true)
    }
    @objc func handleDismissal() {
        dismissInfoView(pokemon: nil)
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
        collectionViewDelegate = PokemonCollectionViewDelegate(pokemons: pokemons, delegate: self)
        
        collectionView.delegate = collectionViewDelegate
        collectionView.dataSource = collectionViewDataSource
        collectionView.reloadData()
    }
    
    
    //MARK: - HELPER FUNCTIONS
    func showPokemonInfoController(withPokemon pokemon: Pokemon) {
        let controller = PokemonInfoController()
        controller.pokemon = pokemon
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureSearchBar(shouldShow: Bool) {
        
        if shouldShow {
            searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder()
            searchBar.tintColor = .white
            
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            inSearchMode = false
            collectionView.reloadData()
        }
    }
    
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func dismissInfoView(pokemon: Pokemon?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.infoView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            guard let pokemon = pokemon else { return }
            //  self.showPokemonInfoController(withPokemon: pokemon)
        }
    }
    
    func configureViewComponents(){
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .mainPink()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Pokedex"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        
        //fecha Uiview de info quando clica fora
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        visualEffectView.alpha = 0
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(gesture)
        //
    }
}

// MARK: - UISearchBarDelegate
extension PokedexController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearchBar(shouldShow: false)
        self.setupCollectionView(width: self.pokemon)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            //collectionView.reloadData()
            self.setupCollectionView(width: self.pokemon)
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            self.setupCollectionView(width: filteredPokemon)
            //collectionView.reloadData()
        }
    }
}

// MARK: - PokedexCellDelegate
extension PokedexController: PokedexCellDelegate {
    
    func presentInfoView(withPokemon pokemon: Pokemon) {
        print("passou")
        
        configureSearchBar(shouldShow: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(infoView)
        infoView.configureViewComponents()
        infoView.delegate = self
        infoView.pokemon = pokemon
        infoView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 64, height: 350)
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        
        infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        infoView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.infoView.alpha = 1
            self.infoView.transform = .identity
        }
    }
}

// MARK: - InfoViewDelegate
extension PokedexController: InfoViewDelegate {
    
    func dismissInfoView(withPokemon pokemon: Pokemon?) {
        dismissInfoView(pokemon: pokemon)
    }
}

// MARK: - PokedexSelectionDelegate
extension PokedexController: PokemonSelectionDelegate {
    func didSelect(pokemon: Pokemon) {
        let poke = pokemon
        var pokemonEvoArray = [Pokemon]()
        
        if let evoChain = poke.evolutionChain {
            let evolutionChain = EvolutionChain(evolutionArray: evoChain)
            let evoIds = evolutionChain.evolutionIds
            
            evoIds.forEach { (id) in
                pokemonEvoArray.append(self.pokemon[id - 1])
            }
            poke.evoArray = pokemonEvoArray
        }
        print(poke)
        showPokemonInfoController(withPokemon: poke)
    }
    
    
}
