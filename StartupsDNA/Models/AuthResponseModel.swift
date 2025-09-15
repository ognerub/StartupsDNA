//
//  AuthResponseModel.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 15.09.2025.
//


import Foundation

struct AuthResponseModel: Codable {
    let id: Int
    let jsonrpc: String
    let result: AuthResultModel
}

struct AuthResultModel: Codable {
    let accessToken: String
    let me: UserDataModel
}

struct UserDataModel: Codable {
    let id: Int
    let name: String
}
