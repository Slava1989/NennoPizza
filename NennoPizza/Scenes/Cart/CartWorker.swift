//
//  CartWorker.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import Foundation

protocol CartWorkerInterface: AnyObject {
    func checkout(pizzaList: [Home.FetchPizza.Pizza], drinkIds: [Int], onComplete: @escaping (String?) -> ())
}

final class CartWorker: CartWorkerInterface {
    func checkout(pizzaList: [Home.FetchPizza.Pizza], drinkIds: [Int], onComplete: @escaping (String?) -> ()) {
        guard let url = URL(string: CartModels.FetchCart.Request.url.rawValue) else {
            onComplete("Wrong URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                onComplete("Something went wrong during ingridients request")
                return
            }
            onComplete(nil)
        }.resume()
    }
}
