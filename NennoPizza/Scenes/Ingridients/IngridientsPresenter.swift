//
//  IngridientsPresenter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 05.06.2023.
//

import UIKit
import SDWebImage

protocol IngridientsPresenterInterface: AnyObject {
    func getAllIngridients()
    func getPizzaImage()
    func updateCheckoutButton()
    func saveToCart()
}

final class IngridientsPresenter: IngridientsPresenterInterface {
    private var output: IngridientsViewControllerInterface
    private var pizzaViewModel: Home.FetchPizza.PizzaViewModel
    private var ingridients: [Home.FetchIngredients.Ingridient]
    private var viewModelList: [IngridientsModels.IngridientsViewModel] = []
    private var finalPrice: Double = 0.0
    
    init(output: IngridientsViewControllerInterface, pizza: Home.FetchPizza.PizzaViewModel, ingridients: [Home.FetchIngredients.Ingridient]) {
        self.output = output
        self.pizzaViewModel = pizza
        self.ingridients = ingridients
    }
    
    func getAllIngridients() {
        self.viewModelList = ingridients.map { ingridient -> IngridientsModels.IngridientsViewModel in
            let isSelected = pizzaViewModel.pizza.ingredients.contains { $0 == ingridient.id }
            let viewModel = IngridientsModels.IngridientsViewModel(id: ingridient.id,
                                                                   name: ingridient.name,
                                                                   price: ingridient.price,
                                                                   isSelected: isSelected)
            return viewModel
        }.sorted { $0.name < $1.name }
        
        output.displayFetchedIngridients(viewModelList: viewModelList)
    }
    
    func getPizzaImage() {
        guard let imageURL = pizzaViewModel.imageURL,
            !imageURL.contains("error")
        else {
            output.displayPizzaImageAndName(image: UIImage(systemName: "x.circle"), url: nil, name: pizzaViewModel.pizza.name)
            return
        }
        
        output.displayPizzaImageAndName(image: nil, url: imageURL, name: pizzaViewModel.pizza.name)
        
    }
    
    func updateCheckoutButton() {
        finalPrice = viewModelList.filter { $0.isSelected }.reduce(0) { $0 + $1.price }
        finalPrice += 4
        output.updateCheckoutButton(price: finalPrice)
    }
    
    func saveToCart() {
        let cartModel = GoodCartModel(name: pizzaViewModel.pizza.name, price: finalPrice, type: .pizza(pizzaViewModel))
        Cart.shared.saveToCart(good: cartModel)
    }
}
