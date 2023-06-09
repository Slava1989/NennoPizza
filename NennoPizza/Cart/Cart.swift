//
//  Cart.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import Foundation

enum GoodType {
    case pizza(Home.FetchPizza.PizzaViewModel)
    case drink(DrinksScreen.FetchDrinks.Drinks)
}

public struct GoodCartModel: Equatable {
    public static func == (lhs: GoodCartModel, rhs: GoodCartModel) -> Bool {
        return lhs.name == rhs.name
    }
    var name: String
    var price: Double
    var type: GoodType
}

//struct Pizza: Codable {
//    let ingredients: [Int]
//    let name: String
//    let imageURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case ingredients, name
//        case imageURL = "imageUrl"
//    }
//}

final public class Cart {
    private var goods: [GoodCartModel]
    
    public static let shared = Cart()
    
    private init() {
        self.goods = []
    }
    
    public func saveToCart(good: GoodCartModel) {
        self.goods.append(good)
    }
    
    public func retrieveGoods() -> [GoodCartModel] {
        return goods
    }
    
    public func removeItemAt(index: Int) {
        self.goods.remove(at: index)
    }
    
    public func removeItemFromCart(good: GoodCartModel) {
        guard let index = goods.firstIndex(of: good) else { return }
        self.goods.remove(at: index)
    }
    
    public func removeAll() {
        self.goods.removeAll()
    }
}
