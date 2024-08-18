//
//  ContentView.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 12.08.2024.
//

import SwiftUI

struct ContentView: View {

    @StateObject var cartManager = CartManager()

    var body: some View {
        ZStack(alignment: .bottom) {
            Home()
                .environmentObject(cartManager)
            
            if cartManager.products.count > 0 {
                CartSummaryView()
                    .environmentObject(cartManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
