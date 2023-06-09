//
//  HomeWorker.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import Foundation

protocol HomeWorkerInterface: AnyObject {
    func fetchPizza(onComplete: @escaping (_ response: Home.FetchPizza.PizzaList?, String?) -> ())
    func fetchIngridients(onComplete: @escaping (_ response: [Home.FetchIngredients.Ingridient]?, String?) -> ())
}

final class HomeWorker: HomeWorkerInterface {
    func fetchIngridients(onComplete: @escaping ([Home.FetchIngredients.Ingridient]?, String?) -> ()) {
        guard let url = URL(string: Home.FetchIngredients.Request.url.rawValue) else {
            onComplete(nil, "Wrong URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                onComplete(nil, "Something went wrong during ingridients request")
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                onComplete(nil, "Wrong access")
                return
            }
            
            do {
                let ingridients = try JSONDecoder().decode([Home.FetchIngredients.Ingridient].self, from: data)
                onComplete(ingridients, nil)
            } catch {
                onComplete(nil, "Error while decoding ingridient data")
            }
        }.resume()
    }
    
    func fetchPizza(onComplete: @escaping (Home.FetchPizza.PizzaList?, String?) -> ()) {
        guard let url = URL(string: Home.FetchPizza.Request.url.rawValue) else {
            onComplete(nil, "Wrong URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                onComplete(nil, "Something went wrong during pizza request")
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                onComplete(nil, "Wrong access")
                return
            }
            
            do {
                let pizzas = try JSONDecoder().decode(Home.FetchPizza.PizzaList.self, from: data)
                onComplete(pizzas, nil)
            } catch {
                onComplete(nil, "Error while decoding pizza data")
            }
        }.resume()
    }
}
