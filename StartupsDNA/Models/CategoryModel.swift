//
//  CategoryModel.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 15.09.2025.
//


import Foundation

struct Category: Identifiable {
    let id: UUID
    let isFavorite: Bool
    let image: String
}
