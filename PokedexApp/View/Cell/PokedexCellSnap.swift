//
//  PokedexCellSnap.swift
//  PokedexApp
//
//  Created by ely.assumpcao.ndiaye on 24/09/19.
//  Copyright © 2019 Ely Assumpcao Ndiaye. All rights reserved.
//

import Foundation
import UIKit
import Reusable

protocol PokedexCellDelegate {
    func presentInfoView(withPokemon pokemon: Pokemon)
}

final class PokedexCellSnap: UICollectionViewCell, Reusable{
    
    //MARK: - PROPERTIES
    var delegate: PokedexCellDelegate?
    
    var pokemon: Pokemon? {
        didSet {
            nameLabel.text = pokemon?.name?.capitalized
            imageView.image = pokemon?.image
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .groupTableViewBackground
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Bulbasaur"
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            guard let pokemon = self.pokemon else { return }
            delegate?.presentInfoView(withPokemon: pokemon)
        }
    }
    
}

extension PokedexCellSnap: CodeView{
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(nameContainerView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(self.frame.height - 32)
        }
        nameContainerView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview()
            make.height.equalTo(32)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
}
