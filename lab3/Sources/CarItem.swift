//
//  CarItem.swift
//  lab3
//
//  Created by Baisal Kenesbek on 01.10.2025.
//

struct CartItem {
    let product: Product
    private(set) var quantity: Int

    init(product: Product, quantity: Int = 1) {
        self.product = product
        self.quantity = max(1, quantity)
    }

    mutating func increaseQuantity(by amount: Int = 1) {
        quantity += amount
    }

    mutating func decreaseQuantity(by amount: Int = 1) {
        quantity = max(1, quantity - amount)
    }

    var subtotal: Double {
        return Double(quantity) * product.price
    }
}
