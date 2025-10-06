// Tests.swift
import Foundation

func runDemo() {
    // Демонстрация работы
    let product1 = Product(id: 1, name: "iPhone", price: 999.99)
    let product2 = Product(id: 2, name: "AirPods", price: 199.99)

    let cart = ShoppingCart()
    cart.addItem(product1, quantity: 2)
    cart.addItem(product2, quantity: 1)

    print("Cart subtotal:", cart.subtotal)
    print("Cart total (без скидки):", cart.total)
    cart.discountRate = 0.1
    print("Cart total (со скидкой 10%):", cart.total)

    let order = Order(cart: cart)
    print(order.formattedSummary())

    let address = Address(street: "Main St 123", city: "Almaty", zipCode: "050000", country: "Kazakhstan")
    print("Доставка по адресу:", address.formattedAddress())

    // Проверка разницы class vs struct
    let cart2 = cart
    cart2.addItem(product2, quantity: 3) // cart2 меняет cart, потому что class
    print("Cart1 items:", cart.itemCount)
    print("Cart2 items:", cart2.itemCount)

    var itemA = CartItem(product: product1, quantity: 1)
    var itemB = itemA
    itemB.increaseQuantity()
    print("itemA qty:", itemA.quantity) // не изменился
    print("itemB qty:", itemB.quantity) // изменился, потому что struct копируется
}
