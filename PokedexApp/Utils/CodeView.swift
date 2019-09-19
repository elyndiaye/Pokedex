//
//  CodeView.swift
//  PokedexApp
//
//  Created by ely.assumpcao.ndiaye on 18/09/19.
//  Copyright © 2019 Ely Assumpcao Ndiaye. All rights reserved.
//

import Foundation
import SnapKit

protocol CodeView{
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

//Para garantir que os metodos vao ser executados na ORDEM correta
extension CodeView{
    func setupView(){
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
