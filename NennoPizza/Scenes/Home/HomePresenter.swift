//
//  HomePresenter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import Foundation

protocol HomePresenterInterface: AnyObject {
    func presentFetchedPizzas(pizzas: Home.FetchPizza.PizzaList, ingridients: [Home.FetchIngredients.Ingridient])
    func showErrorMessage(errorMessage: String)
    func updateCartView(numberOfGoods: Int)
}

final class HomePresenter: HomePresenterInterface {
    private var viewModelList: [Home.FetchPizza.PizzaViewModel] = []
    var output: HomeViewControllerInterface
    
    init(output: HomeViewControllerInterface) {
        self.output = output
    }
    
    func presentFetchedPizzas(pizzas: Home.FetchPizza.PizzaList, ingridients: [Home.FetchIngredients.Ingridient]) {
        let viewModelList = pizzas.pizzas.map { pizza -> Home.FetchPizza.PizzaViewModel in
            var sum = 0.0
            let ingridientList = pizza.ingredients.map { ingridientId in
                let foundIngridient = ingridients.first { $0.id == ingridientId }
                sum += foundIngridient?.price ?? 0.0
                return (ingridientId, foundIngridient?.name ?? "")
            }
            
            return  Home.FetchPizza.PizzaViewModel(pizza: pizza,
                                                   ingridients: ingridientList,
                                                   finalPrice: sum + pizzas.basePrice,
                                                   imageURL: pizza.imageURL)
        }
        
        output.displayFetchedPizzas(viewModelList: viewModelList, ingridients: ingridients)
    }
    
    func updateCartView(numberOfGoods: Int) {
        output.updateCartView(numberOfGoods: numberOfGoods)
    }
    
    func showErrorMessage(errorMessage: String) {
        output.showErrorMessage(message: errorMessage)
    }
}
