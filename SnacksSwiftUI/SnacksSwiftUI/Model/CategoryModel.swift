//
//  CategoryModel.swift
//  SnacksSwiftUI
//
//  Created by Kaan Yalçınkaya on 13.08.2024.
//

import SwiftUI

struct CategoryModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var icon: String
    var title: String
}

let categoryList: [CategoryModel] = [
    CategoryModel(icon: "square.grid.2x2", title: "All"),
    CategoryModel(icon: "muffin", title: "Muffin"),
    CategoryModel(icon: "choco", title: "Choco"),
    CategoryModel(icon: "chips", title: "Chips")
]
