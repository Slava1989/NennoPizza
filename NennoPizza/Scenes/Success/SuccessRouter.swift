//
//  SuccessRouter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 09.06.2023.
//

import UIKit

protocol SuccessRouterInterface: AnyObject {
    func returnToHomeScreen()
}

final class SuccessRouter: SuccessRouterInterface {
    private var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func returnToHomeScreen() {
        rootViewController.popToRootViewController(animated: true)
    }
}
