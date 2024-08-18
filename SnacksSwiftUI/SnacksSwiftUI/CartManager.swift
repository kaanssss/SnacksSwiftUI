//
//  CartManager.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 13.08.2024.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Double = 0.0
    
    func addToCart(product: Product) {
        products.append(product)
        total += product.price
        print("Current cart: \(products.count) products, total: \(String(format: "%.2f", total))")
    }

//    func removeFromCart(product: Product) {
//        products = products.filter { $0.id != product.id }
//        total -= product.price
//        print("Product removed. Current cart: \(products.count) products, total: \(String(format: "%.2f", total))")
//    }
    
    func removeFromCart(at offsets: IndexSet) {
            offsets.forEach { index in
                total -= products[index].price
            }
            products.remove(atOffsets: offsets)
        }
    
       func clearCart() {
           products.removeAll()
           total = 0.0
       }
}

