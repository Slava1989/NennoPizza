//
//  CartInteractor.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import Foundation

protocol CartInteractorInterface: AnyObject {
    func getTotalSum()
    func removeItemFromCart(index: Int)
    func checkout()
}

final class CartInteractor: CartInteractorInterface {
    private var worker: CartWorkerInterface
    var output: CartPresenterInterface?
    
    init(worker: CartWorkerInterface) {
        self.worker = worker
    }
    
    func getTotalSum() {
        output?.getTotalSum()
    }
    
    func removeItemFromCart(index: Int) {
        Cart.shared.removeItemAt(index: index)
    }
    
    func checkout() {
        let orderGoods = Cart.shared.retrieveGoods()
        
        var orderedPizzas = [Home.FetchPizza.Pizza]()
        var orderedDrinks = [Int]()
        
        orderGoods.forEach { cartModel in
            switch cartModel.type {
            case .pizza(let pizzaViewModel):
                let ingridientsId = pizzaViewModel.ingridients.map { $0.0 }
                let orderedPizza = Home.FetchPizza.Pizza(ingredients: ingridientsId,
                                                         name: pizzaViewModel.pizza.name,
                                                         imageURL: pizzaViewModel.imageURL)
                orderedPizzas.append(orderedPizza)
            case .drink(let drinks):
                orderedDrinks.append(drinks.id)
            }
        }
        
        worker.checkout(pizzaList: orderedPizzas, drinkIds: orderedDrinks) { errorMessage in
            DispatchQueue.main.async {
                if errorMessage == nil {
                    Cart.shared.removeAll()
                    self.output?.showSuccessScreen()
                }
            }
        }
    }
}
