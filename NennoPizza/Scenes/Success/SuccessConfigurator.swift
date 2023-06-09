//
//  SuccessConfigurator.swift
//  NennoPizza
//
//  Created by Slava Chirita on 09.06.2023.
//

import UIKit

final class SuccessConfigurator {
    func configureSuccessScreen(rootController: UINavigationController) -> UIViewController {
        let router = SuccessRouter(rootViewController: rootController)
        let viewController = SuccessViewController(router: router)
        
        return viewController
    }
}
