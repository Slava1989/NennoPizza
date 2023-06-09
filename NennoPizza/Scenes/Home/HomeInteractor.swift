//
//  HomeInteractor.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import Foundation

protocol HomeInteractorInterface: AnyObject {
    func getPizzas()
    func saveToCart(pizzaModel: Home.FetchPizza.PizzaViewModel)
    func checkCart()
}

final class HomeInteractor: HomeInteractorInterface {
    private var worker: HomeWorkerInterface
    var output: HomePresenterInterface?
    
    init(worker: HomeWorkerInterface) {
        self.worker = worker
    }
    
    func getPizzas() {
        var ingridients = [Home.FetchIngredients.Ingridient]()
        var pizzasList: Home.FetchPizza.PizzaList?
        let group = DispatchGroup()
        
        group.enter()
        worker.fetchIngridients { ingridientResponse, ingridientErrorMessage in
            ingridients = ingridientResponse!
            group.leave()
        }
        
        group.enter()
        worker.fetchPizza { response, errorMessage in
            pizzasList = response!
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let pizzasList = pizzasList else {
                self?.output?.showErrorMessage(errorMessage: "")
                return
            }
            
            self?.output?.presentFetchedPizzas(pizzas: pizzasList, ingridients: ingridients)
        }
    }
    
    func saveToCart(pizzaModel: Home.FetchPizza.PizzaViewModel) {
        let cartModel = GoodCartModel(name: pizzaModel.pizza.name, price: pizzaModel.finalPrice, type: .pizza(pizzaModel))
        Cart.shared.saveToCart(good: cartModel)
        checkCart()
    }
    
    func checkCart() {
        let count = Cart.shared.retrieveGoods().count
        output?.updateCartView(numberOfGoods: count)
    }
}
