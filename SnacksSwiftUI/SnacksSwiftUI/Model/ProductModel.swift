//
//  ProductModel.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 13.08.2024.
//

import SwiftUI

struct Product: Identifiable {
    var id: UUID = UUID()
    var name: String
    var category: String
    var image: String
    var color: Color
    var price: Double
}

var productList = [
    Product(name: "Pringles Original", category: "Chips", image: "pringles", color: Color(red: 1.0, green: 1.0, blue: 0.6), price: 2.29),
    Product(name: "Snickers Bar", category: "Choco", image: "snickers", color: Color(red: 0.35, green: 0.16, blue: 0.05), price: 1.49),
    Product(name: "Blueberry Muffin", category: "Muffin", image: "muffin", color: Color(red: 0.88, green: 0.92, blue: 0.97), price: 2.50),
    Product(name: "Mixed Muffins", category: "Muffin", image: "muffins", color: Color(red: 0.85, green: 0.74, blue: 0.60), price: 5.99),
    Product(name: "Muffin Basket", category: "Muffin", image: "muffinsss", color: Color(red: 0.55, green: 0.35, blue: 0.20), price: 10.99),
    Product(name: "Kinder Bueno", category: "Choco", image: "bueno", color: Color(red: 1.0, green: 0.8, blue: 0.6), price: 2.00),
    Product(name: "Ferrero Rocher", category: "Choco", image: "ferrero", color: Color(red: 0.87, green: 0.72, blue: 0.52), price: 2.00),
    Product(name: "Kinder Milk Slice", category: "Choco", image: "kinder", color: Color(red: 0.85, green: 0.88, blue: 0.90), price: 1.50)
]






