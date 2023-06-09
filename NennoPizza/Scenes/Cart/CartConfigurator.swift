//
//  CartConfigurator.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import UIKit

final class CartConfigurator {
    func configureCartScreen(rootController: UINavigationController) -> UIViewController {
        let interactor = CartInteractor(worker: CartWorker())
        let router = CartRouter(rootViewController: rootController)
        let viewController = CartViewController(output: interactor, router: router)
        let presenter = CartPresenter(output: viewController)
        interactor.output = presenter
        
        return viewController
    }
}
