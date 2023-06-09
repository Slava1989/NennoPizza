//
//  CartModels.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import Foundation

enum CartModels {
    enum FetchCart {
        enum Request: String {
            case url = "http://httpbin.org/post"
        }
        
        struct CardCheckoutReques: Codable {
            let pizzas: [Home.FetchPizza.Pizza]
            let drinks: [Int]
        }

    }
}
