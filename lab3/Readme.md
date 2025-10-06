📘 Description
This lab demonstrates the use of classes, structures, and object-oriented programming concepts in Swift.
It simulates a simple shopping system, including products, cart management, discounts, and orders.

🧩 Project Structure
Lab3/
├── Sources/
│   ├── lab3/
│   │   ├── Product.swift
│   │   ├── CartItem.swift
│   │   ├── ShoppingCart.swift
│   │   ├── Order.swift
│   │   ├── Address.swift
│   │   ├── main.swift
│   │   └── Demo.swift
└── Tests/
    └── lab3Tests/
        ├── Tests.swift
Files Overview
Product.swift — defines a product with id, name, and price.
CartItem.swift — represents an item in the cart (a product + quantity).
ShoppingCart.swift — manages the list of items, subtotal, and discounts.
Order.swift — represents an order created from a shopping cart.
Address.swift — defines the delivery address structure.
main.swift — entry point that calls runDemo().
Demo.swift / Tests.swift — demonstrates functionality and tests differences between class and struct.

🚀 How to Run
Open the project in Xcode.
Make sure the lab3 scheme is selected.
Press Run (Cmd + R) to execute the program.
To run tests, choose Product → Test (Cmd + U).


💡 Example Output
Cart subtotal: 2199.97
Cart total (without discount): 2199.97
Cart total (with 10% discount): 1979.97
Order summary:
Product: iPhone x2
Product: AirPods x1
Total: 1979.97
Delivery to: Main St 123, Almaty, 050000, Kazakhstan


🧠 Key Concepts
Difference between class (reference type) and struct (value type).
Working with objects, initializers, and methods.
Modeling real-world entities in Swift.
Encapsulation and modular code design.


⚙️ Requirements
macOS 13+
Xcode 15+
Swift 5.9 or newer

