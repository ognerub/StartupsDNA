//
//  AuthRequestModel.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 15.09.2025.
//

import Foundation

struct AuthRequestModel: Codable {
    let id: Int
    let jsonrpc: String
    let method: String
    let params: AuthRequestParams
}

struct AuthRequestParams: Codable {
    let fbIdToken: String
}
