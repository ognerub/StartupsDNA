//
//  LoginButton.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//


import SwiftUI

struct LoginButton: View {

    let title: LocalizedStringKey
    let image: ImageResource
    let action: (() -> Void)?

    var body: some View {
        Button(action: {
            action?()
        }, label: {
            HStack {
                Image(image)
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.customBlack)
            }
            .padding(16)
            .frame(maxWidth: .infinity, idealHeight: 56)
            .background(.customWhite)
            .cornerRadius(10)
        })
    }
}
