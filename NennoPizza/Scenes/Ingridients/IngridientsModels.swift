//
//  IngridientsModels.swift
//  NennoPizza
//
//  Created by Slava Chirita on 05.06.2023.
//

import Foundation

enum IngridientsModels {
    class IngridientsViewModel {
        var id: Int
        var name: String
        var price: Double
        var isSelected: Bool
        
        init(id: Int, name: String, price: Double, isSelected: Bool) {
            self.id = id
            self.name = name
            self.price = price
            self.isSelected = isSelected
        }
        
        func selectIngridient() {
            isSelected = !isSelected
        }
    }
}
