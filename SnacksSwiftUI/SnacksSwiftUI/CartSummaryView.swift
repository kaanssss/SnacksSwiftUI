//
//  CartSummaryView.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 17.08.2024.
//

// CartSummaryView.swift
import SwiftUI

struct CartSummaryView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var isCartViewPresented = false

    var body: some View {
        Button(action: {
            isCartViewPresented = true
        }) {
            HStack {
                HStack(spacing: 10) {
                    Text("\(cartManager.products.count)")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 40, height: 40)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .foregroundColor(.black)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Cart")
                            .font(.system(size: 22, weight: .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)

                        Text("\(cartManager.products.count) Items")
                            .font(.system(size: 16))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .layoutPriority(1)
                }

                Spacer()

                HStack(spacing: -20) {
                    ForEach(cartManager.products.suffix(6).reversed(), id: \.id) { product in
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                            .frame(width: 50, height: 50)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding([.leading, .trailing], 20)
        }
        .fullScreenCover(isPresented: $isCartViewPresented) {
            CartView()
                .environmentObject(cartManager)
        }
    }
}

#Preview {
    CartSummaryView()
        .environmentObject(CartManager())
}







