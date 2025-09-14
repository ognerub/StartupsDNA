//
//  ViewModel.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//

import SwiftUI

final class ViewModel: ObservableObject {
    @Published var isSignedInApple: Bool = false
    @Published var isSignedInGoogle: Bool = false
    @Published var searchText: String = ""
    @Published var selectedCurrency: Currency = .USD

    @Published var banners: [Banner] = Mocks.banners
    @Published var collections: [Collection] = Mocks.collections
    @Published var categories: [Category] = Mocks.categories

    func toggleFavoriteCategory(_ category: Category) {
        if let index = categories.firstIndex(where: { category.id == $0.id }) {
            let category = categories[index]
            let newCategory = Category(
                id: category.id,
                isFavorite: !category.isFavorite,
                image: category.image
            )
            categories[index] = newCategory
        }
    }
}

// MARK: - Mocks

enum Currency: LocalizedStringKey, CaseIterable {
    case USD
    case RUB
    case UZS

    var flag: String {
        switch self {
        case .USD: return "🇺🇸"
        case .RUB: return "🇷🇺"
        case .UZS: return "🇺🇿"
        }
    }
}

struct Banner: Identifiable, Codable {
    let id: UUID
    let title: String
    let action: String
    let primaryColor: String
    let secondaryColor: String
    let image: String
}

struct Collection: Identifiable, Codable {
    let id: UUID
    let title: String
    let image: String
}

struct Category: Identifiable, Codable {
    let id: UUID
    let isFavorite: Bool
    let image: String
}

enum Mocks {
    static let banners = [
        Banner(id: UUID(), title: "UPCOMING \nHOLIDAYS SOON", action: "Call to action", primaryColor: "customDeepRose", secondaryColor: "customLightRose", image: "bannerRoses"),
        Banner(id: UUID(), title: "FATER \nTHEN EVER", action: "Look around", primaryColor: "customLightGray", secondaryColor: "customLightBlue", image: "bannerBoots"),
        Banner(id: UUID(), title: "STOP NOW \nYOU FOUND IT", action: "Get it now", primaryColor: "customGray", secondaryColor: "customLink", image: "bannerPhone")
    ]

    static let collections = [
        Collection(id: UUID(), title: "New Popular Arrivals", image: "collectionPopularArrivals"),
        Collection(id: UUID(), title: "Mixed Flowers", image: "collectionMixedFlowers"),
        Collection(id: UUID(), title: "Thank you", image: "collectionThankYou"),
        Collection(id: UUID(), title: "New Popular Arrivals", image: "collectionPopularArrivals"),
        Collection(id: UUID(), title: "Mixed Flowers", image: "collectionMixedFlowers"),
        Collection(id: UUID(), title: "Thank you", image: "collectionThankYou")
    ]

    static let categories = [
        Category(id: UUID(), isFavorite: false, image: "categoriesBoots"),
        Category(id: UUID(), isFavorite: false, image: "categoriesBox"),
        Category(id: UUID(), isFavorite: false, image: "categoriesBeats"),
        Category(id: UUID(), isFavorite: false, image: "categoriesGlasses"),
        Category(id: UUID(), isFavorite: false, image: "categoriesBoots"),
        Category(id: UUID(), isFavorite: false, image: "categoriesBox"),
        Category(id: UUID(), isFavorite: false, image: "categoriesBeats"),
        Category(id: UUID(), isFavorite: false, image: "categoriesGlasses")
    ]
}
