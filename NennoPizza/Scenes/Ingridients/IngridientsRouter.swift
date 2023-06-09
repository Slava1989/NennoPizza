//
//  IngridientsRouter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 05.06.2023.
//

import UIKit

protocol IngridientRouterInterface: AnyObject {
}

final class IngridientsRouter: IngridientRouterInterface {
 
    private var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}
