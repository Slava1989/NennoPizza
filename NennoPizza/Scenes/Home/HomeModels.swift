//
//  HomeModels.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import Foundation

enum Home {
    enum FetchPizza {
        enum Request: String {
            case url = "https://doclerlabs.github.io/mobile-native-challenge/pizzas.json"
        }
        
        struct PizzaList: Codable {
            let basePrice: Double
            let pizzas: [Pizza]
        }

        // MARK: - Pizza
        struct Pizza: Codable {
            let ingredients: [Int]
            let name: String
            let imageURL: String?

            enum CodingKeys: String, CodingKey {
                case ingredients, name
                case imageURL = "imageUrl"
            }
        }
        
        struct PizzaViewModel {
            var pizza: Pizza
            var ingridients: [(Int, String)]
            var finalPrice: Double
            var imageURL: String?
        }
    }
    
    enum FetchIngredients {
        enum Request: String {
            case url = "https://doclerlabs.github.io/mobile-native-challenge/ingredients.json"
        }
        
        struct Ingridient: Codable {
            var id: Int
            var name: String
            var price: Double
        }
        struct IngridientsViewModel {
            var ingridient: [Ingridient]
        }
    }
}
