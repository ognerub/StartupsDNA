//
//  BannerModel.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 15.09.2025.
//


import Foundation

struct Banner: Identifiable {
    let id: UUID
    let title: String
    let action: String
    let primaryColor: String
    let secondaryColor: String
    let image: String
}
