//
//  CartView.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 13.08.2024.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var mode
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Cart")
                        .font(.system(size: 24, weight: .semibold))
                    Spacer()
                    HStack {
                        Text("\(cartManager.products.count)")
                            .frame(width: 40, height: 40)
                            .background(Color.yellow)
                            .clipShape(Circle())
                            .foregroundColor(.black)
                        
                        Button(action: {
                            showAlert = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 10)
                    }
                }
                .padding()
                .background(Color.white)
                .shadow(radius: 5)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            // Cart Items
            List {
                ForEach(cartManager.products, id: \.name) { item in
                    CartProductCard(product: item)
                }
                .onDelete(perform: cartManager.removeFromCart)
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal)
            
            // Total Amount
            VStack(alignment: .leading) {
                HStack {
                    Text("Delivery Amount")
                    Spacer()
                    Text("Free")
                        .font(.system(size: 24, weight: .semibold))
                }
                
                Divider()
                
                Text("Total Amount")
                    .font(.system(size: 24))
                
                Text("USD \(String(format: "%.2f", Double(cartManager.total)))")
                    .font(.system(size: 36, weight: .semibold))
            }
            .padding(30)
            .frame(maxWidth: .infinity)
            .background(Color.yellow.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
            
            // Make Payment Button
            Button {
                // Payment action
            } label: {
                Text("Make Payment")
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.yellow.opacity(0.7))
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .padding()
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Clear Cart"),
                message: Text("Are you sure you want to remove all items from your cart?"),
                primaryButton: .destructive(Text("Clear")) {
                    cartManager.clearCart()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartManager())
}

struct CartProductCard: View {
    
    var product: Product
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("\(product.name)")
                    .font(.headline)
                Text(product.category)
                    .font(.callout)
                    .opacity(0.5)
            }
            
            Spacer()
            
            Text(formattedPrice(product.price))
                .padding()
                .background(Color.yellow.opacity(0.5))
                .clipShape(Capsule())
        }
    }
    
    func formattedPrice(_ price: Double) -> String {
        if price.truncatingRemainder(dividingBy: 1) == 0 {
            return "$\(Int(price))"
        } else {
            return "$\(String(format: "%.2f", price))"
        }
    }
}


