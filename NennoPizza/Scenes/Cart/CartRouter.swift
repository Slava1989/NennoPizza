//
//  CartRouter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import UIKit

protocol CartRouterInterface: AnyObject {
    func returnToPizzaScreen()
    func showDrinksScreen()
    func showSuccessScreen()
}

final class CartRouter: CartRouterInterface {
    private var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func returnToPizzaScreen() {
        rootViewController.popViewController(animated: true)
    }
    
    func showDrinksScreen() {
        let drinksConfigurator = DrinksConfigurator()
        let destination = drinksConfigurator.configureDrinksScreen(rootController: rootViewController)
        rootViewController.pushViewController(destination, animated: true)
    }
    
    func showSuccessScreen() {
        let successConfigurator = SuccessConfigurator()
        let destination = successConfigurator.configureSuccessScreen(rootController: rootViewController)
        rootViewController.pushViewController(destination, animated: true)
    }
}
