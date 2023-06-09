//
//  IngridientsConfigurator.swift
//  NennoPizza
//
//  Created by Slava Chirita on 05.06.2023.
//

import UIKit

final class IngridientsConfigurator {
    func configureIngridientsScreen(rootController: UINavigationController, pizza: Home.FetchPizza.PizzaViewModel, ingridients: [Home.FetchIngredients.Ingridient]) -> UIViewController {
        let interactor = IngridientsInteractor()
        let router = IngridientsRouter(rootViewController: rootController)
        let viewController = IngridientsViewController(output: interactor, router: router)
        let presenter = IngridientsPresenter(output: viewController, pizza: pizza, ingridients: ingridients)
        interactor.output = presenter
        
        return viewController
    }
}
