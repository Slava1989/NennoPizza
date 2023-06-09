//
//  DrinksModels.swift
//  NennoPizza
//
//  Created by Slava Chirita on 08.06.2023.
//

import Foundation

enum DrinksScreen {
    enum FetchDrinks {
        enum Request: String {
            case url = "https://doclerlabs.github.io/mobile-native-challenge/drinks.json"
        }
        
        struct Drinks: Codable {
            let price: Double
            let name: String
            let id: Int
        }
        
        struct DrinksViewModel {
            var drinks: [Drinks]
        }
    }
}

