//
//  CartPresenter.swift
//  NennoPizza
//
//  Created by Slava Chirita on 06.06.2023.
//

import Foundation

protocol CartPresenterInterface: AnyObject {
    func getTotalSum()
    func showSuccessScreen()
}

final class CartPresenter: CartPresenterInterface {
    private var output: CartViewControllerInterface
    
    init(output: CartViewControllerInterface) {
        self.output = output
    }
    
    func getTotalSum() {
        let totalSum = Cart.shared.retrieveGoods().reduce(0) { $0 + $1.price }
        
        if totalSum > 0 {
            output.setTotalSum(totalSum: totalSum)
            return
        }
        
        output.showEmptyCartMessage()
    }
    
    func showSuccessScreen() {
        output.showSuccessScreen()
    }
}
