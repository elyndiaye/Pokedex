//
//  ApperanceProxyHelper.swift
//  PokedexApp
//
//  Created by Ely Assumpcao Ndiaye on 01/09/2019.
//  Copyright © 2019 Ely Assumpcao Ndiaye. All rights reserved.
//

import Foundation
import UIKit

struct ApperanceProxyHelper {
    static func customizeNavigationBar(){
        let navigationBarApparence = UINavigationBar.appearance()
        navigationBarApparence.barTintColor = .mainPink()
        navigationBarApparence.barStyle = .black
        navigationBarApparence.isTranslucent = false
    }
}
