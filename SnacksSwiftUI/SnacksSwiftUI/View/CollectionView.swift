//
//  CollectionView.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 13.08.2024.
//

import SwiftUI

struct CollectionView: View {
    
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                    Spacer()
                    Text("Top Snack Picks")
                        .font(.headline)
                    Spacer()
                    Button(action: {}) {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .padding()
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            ScrollView {
                VStack {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(productList, id: \.id) { item in
                            SmallProductCard(product: item)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    CollectionView()
        .environmentObject(CartManager())
}

struct SmallProductCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        ZStack {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding(.trailing, -80)
                .rotationEffect(Angle(degrees: 30))
            
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(product.name)")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 120, alignment: .leading)
                        .minimumScaleFactor(0.8)
                    
                    Text(product.category)
                        .font(.system(size: 10))
                        .padding(6)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                HStack {
                    Text("$\(String(format: "%.2f", product.price))")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        cartManager.addToCart(product: product)
                        print("SmallProductCard added to cart: \(product.name)")
                    }) {
                        Image(systemName: "basket")
                            .imageScale(.large)
                            .frame(width: 45, height: 40)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                    
                }
                .padding(.trailing, -12)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color.white.opacity(0.9))
                .clipShape(Capsule())
            }
            .padding(20)
        }
        .frame(width: 170, height: 215)
        .background(product.color.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.leading, 10)
    }
}
