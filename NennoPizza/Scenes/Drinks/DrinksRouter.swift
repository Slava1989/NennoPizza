//
//  DrinksRouter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 08.06.2023.
//

import UIKit

protocol DrinksRouterInterface: AnyObject {
    
}

final class DrinksRouter: DrinksRouterInterface {
    private var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}
