//
//  ShoppingCart.swift
//  lab3
//
//  Created by Baisal Kenesbek on 01.10.2025.
//

class ShoppingCart {
    private(set) var items: [CartItem] = []
    var discountRate: Double = 0.0 // например, 0.1 = 10%

    func addItem(_ product: Product, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            var updatedItem = items[index]
            updatedItem.increaseQuantity(by: quantity)
            items[index] = updatedItem
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            items.append(newItem)
        }
    }

    func removeItem(productId: Int) {
        items.removeAll { $0.product.id == productId }
    }

    func updateItemQuantity(productId: Int, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.product.id == productId }) else { return }
        var updatedItem = items[index]
        updatedItem = CartItem(product: updatedItem.product, quantity: max(1, quantity))
        items[index] = updatedItem
    }

    func clearCart() {
        items.removeAll()
    }

    var subtotal: Double {
        return items.reduce(0) { $0 + $1.subtotal }
    }

    var discountAmount: Double {
        return subtotal * discountRate
    }

    var total: Double {
        return subtotal - discountAmount
    }

    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}
