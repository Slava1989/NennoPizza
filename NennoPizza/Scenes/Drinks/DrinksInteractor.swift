//
//  DrinksInteractor.swift
//  NennoPizza
//
//  Created by Slava Chirita on 08.06.2023.
//

import Foundation

protocol DrinksInteractorInterface: AnyObject {
    func fetchDrinks()
    func addDrinkToCart(drink: DrinksScreen.FetchDrinks.Drinks?)
}

final class DrinksInteractor: DrinksInteractorInterface {
    private var worker: DrinksWorkerInterface
    var output: DrinksPresenterInterface?
    
    init(worker: DrinksWorkerInterface) {
        self.worker = worker
    }
    
    func fetchDrinks() {
        worker.fetchDrinks { [weak self] drinks, errorMessage in
            guard let drinks = drinks else {
                self?.output?.showErrorMessage(message: errorMessage ?? "")
                return
            }
            
            self?.output?.presentFetchedDrinks(drinks: drinks)
        }
    }
    
    func addDrinkToCart(drink: DrinksScreen.FetchDrinks.Drinks?) {
        guard let drink = drink else {
            return
        }
        
        let order = GoodCartModel(name: drink.name, price: drink.price, type: .drink(drink))
        Cart.shared.saveToCart(good: order)
        print(order)
    }
}
