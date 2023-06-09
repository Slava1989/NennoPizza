//
//  HomeRouter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import UIKit

protocol HomeRouterInterface: AnyObject {
    func showIngridients(for pizza: Home.FetchPizza.PizzaViewModel, ingridients: [Home.FetchIngredients.Ingridient])
    func showCartScreen()
}

final class HomeRouter: HomeRouterInterface {
    private var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func showIngridients(for pizza: Home.FetchPizza.PizzaViewModel, ingridients: [Home.FetchIngredients.Ingridient]) {
        let ingridientsConfigurator = IngridientsConfigurator()
        rootViewController.pushViewController(
            ingridientsConfigurator
                .configureIngridientsScreen(rootController: rootViewController,
                                                               pizza: pizza,
                                            ingridients: ingridients),
            animated: true)
    }
    
    func showCartScreen() {
        let cartConfigurator = CartConfigurator()
        rootViewController.pushViewController(cartConfigurator.configureCartScreen(rootController: rootViewController), animated: true)
    }
}
