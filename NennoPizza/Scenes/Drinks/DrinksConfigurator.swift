//
//  DrinksConfigurator.swift
//  NennoPizza
//
//  Created by Slava Chirita on 08.06.2023.
//

import UIKit

final class DrinksConfigurator {
    func configureDrinksScreen(rootController: UINavigationController) -> UIViewController {
        
        let interactor = DrinksInteractor(worker: DrinksWorker())
        let router = DrinksRouter(rootViewController: rootController)
        let viewController = DrinksViewController(output: interactor, router: router)
        let presenter = DrinksPresenter(output: viewController)
       
        
        interactor.output = presenter
        
        return viewController
    }
}
