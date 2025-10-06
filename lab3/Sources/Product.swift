//
//  Product.swift
//  lab3
//
//  Created by Baisal Kenesbek on 01.10.2025.
//

import Foundation

struct Product {
    let id: Int
    let name: String
    let price: Double

    init(id: Int, name: String, price: Double) {
        guard price >= 0 else {
            fatalError("Цена не может быть отрицательной")
        }
        self.id = id
        self.name = name
        self.price = price
    }

    func formattedPrice() -> String {
        return String(format: "%.2f $", price)
    }
}
