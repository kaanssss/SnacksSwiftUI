//
//  Home.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 12.08.2024.
//

import SwiftUI

struct Home: View {

    // Category View Properties
    @State var selectedCategory = "All"
    @EnvironmentObject var cartManager: CartManager

    var filteredProducts: [Product] {
        if selectedCategory == "All" {
            return productList
        } else {
            return productList.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer(minLength: 10)
                    HeaderView()
                    CategoryListView(selectedCategory: $selectedCategory)
                    ProductListView(selectedCategory: $selectedCategory, filteredProducts: filteredProducts)
                        .environmentObject(cartManager)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// HeaderView
struct HeaderView: View {
    var body: some View {
        HStack {
            Text("**Top** **Snack** **Picks**")
                .font(.system(size: 40))
                .padding(.trailing)
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .imageScale(.large)
                .padding()
                .frame(width: 70, height: 90)
                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
        }
        .padding(.top, -20)
        .padding(.horizontal, 20)
    }
}

#Preview {
    Home()
        .environmentObject(CartManager())
}


// CategoryListView
struct CategoryListView: View {
    @Binding var selectedCategory: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categoryList, id: \.id) { item in
                    Button {
                        selectedCategory = item.title
                    } label: {
                        HStack {
                            Image(systemName: item.icon)
                                .foregroundColor(selectedCategory == item.title ? .yellow : .black)
                            
                            Text(item.title)
                        }
                        .padding(20)
                        .background(selectedCategory == item.title ? .black : .gray.opacity(0.1))
                        .foregroundColor(selectedCategory != item.title ? .black : .white)
                        .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, 30)
        }
    }
}

// ProductListView
struct ProductListView: View {
    @Binding var selectedCategory: String
    @EnvironmentObject var cartManager: CartManager
    
    var filteredProducts: [Product]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(selectedCategory) **Collections**")
                    .font(.system(size: 24))
                
                Spacer()
                
                NavigationLink {
                    CollectionView()
                        .environmentObject(cartManager)
                } label: {
                    Image(systemName: "arrow.right")
                        .imageScale(.large)
                }
                .foregroundColor(.black)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filteredProducts, id: \.id) { item in
                        ProductCard(product: item)
                            .environmentObject(cartManager)
                    }
                }
            }
        }
    }
}

// ProductCardView
struct ProductCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        ZStack {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding(.trailing, -50)
                .rotationEffect(Angle(degrees: 30))
            
            ZStack {
                VStack(alignment: .leading, content: {
                    Text("\(product.name)")
                        .font(.system(size: 31, weight: .semibold))
                        .frame(width: 140)
                    Text(product.category)
                        .font(.callout)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    HStack {
                        Text("$\(String(format: "%.2f", product.price))")
                            .font(.system(size: 24, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            cartManager.addToCart(product: product)
                            print("Added to cart: \(product.name)")
                        } label: {
                            Image(systemName: "basket")
                                .imageScale(.large)
                                .frame(width: 90, height: 68)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                        .padding(-10)
                        
                    }
                    .padding(.leading)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(Color.white.opacity(0.9))
                    .clipShape(Capsule())
                    
                })
            }
            .padding(30)
            .frame(width: 336, height: 422)
        }
        .frame(width: 336, height: 422)
        .background(product.color.opacity(0.13))
        .clipShape(RoundedRectangle(cornerRadius: 57))
        .padding(.leading, 20)
    }
}

#Preview {
    Home()
        .environmentObject(CartManager())
}
