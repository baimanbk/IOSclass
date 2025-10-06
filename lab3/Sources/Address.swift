//
//  Address.swift
//  lab3
//
//  Created by Baisal Kenesbek on 01.10.2025.
//

struct Address {
    let street: String
    let city: String
    let zipCode: String
    let country: String

    func formattedAddress() -> String {
        return "\(street), \(city), \(zipCode), \(country)"
    }
}
