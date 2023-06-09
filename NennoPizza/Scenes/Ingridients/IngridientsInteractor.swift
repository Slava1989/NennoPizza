//
//  IngridientsInteractor.swift
//  NennoPizza
//
//  Created by Slava Chirita on 05.06.2023.
//

import Foundation

protocol IngridientsInteractorInterface: AnyObject {
    func getPizzaDetails()
    func updateCheckoutButton()
    func saveToCart()
}

final class IngridientsInteractor: IngridientsInteractorInterface {
    var output: IngridientsPresenterInterface?
    
    func getPizzaDetails() {
        output?.getAllIngridients()
        output?.getPizzaImage()
    }
    
    func updateCheckoutButton() {
        output?.updateCheckoutButton()
    }
    
    func saveToCart() {
        output?.saveToCart()
    }
}
