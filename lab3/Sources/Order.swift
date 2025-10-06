//
//  Order.swift
//  lab3
//
//  Created by Baisal Kenesbek on 01.10.2025.
//

import Foundation

struct Order {
    let id: UUID
    let items: [CartItem]
    let total: Double
    let date: Date

    init(cart: ShoppingCart) {
        self.id = UUID()
        self.items = cart.items
        self.total = cart.total
        self.date = Date()
    }

    func formattedSummary() -> String {
        var summary = "Order ID: \(id)\nDate: \(date)\n"
        for item in items {
            summary += "- \(item.product.name) x\(item.quantity) = \(item.subtotal)$\n"
        }
        summary += "Total: \(String(format: "%.2f", total))$\n"
        return summary
    }
}
