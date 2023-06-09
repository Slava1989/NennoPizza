//
//  DrinksPresenter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 08.06.2023.
//

import Foundation

protocol DrinksPresenterInterface: AnyObject {
    func showErrorMessage(message: String)
    func presentFetchedDrinks(drinks: [DrinksScreen.FetchDrinks.Drinks])
}

final class DrinksPresenter: DrinksPresenterInterface {
    private var output: DrinksViewControllerInterface
    
    init(output: DrinksViewControllerInterface) {
        self.output = output
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
            self.output.showErrorMessage(message: message)
        }
    }
    
    func presentFetchedDrinks(drinks: [DrinksScreen.FetchDrinks.Drinks]) {
        DispatchQueue.main.async {
            let viewModel = DrinksScreen.FetchDrinks.DrinksViewModel(drinks: drinks)
            self.output.presentFetchedDrinks(viewModel: viewModel)
        }
    }
}
