//
//  HomeConfigurator.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import UIKit

final class HomeConfigurator {
    func configureHomeScreen() -> UIViewController {
        let navigationController = UINavigationController()
        let interactor = HomeInteractor(worker: HomeWorker())
        let router = HomeRouter(rootViewController: navigationController)
        let viewController = HomeViewController(output: interactor, router: router)
        let presenter = HomePresenter(output: viewController)
        interactor.output = presenter
        
        navigationController.viewControllers = [viewController]

        return navigationController
    }
}
