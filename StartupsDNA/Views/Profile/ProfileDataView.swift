//
//  ProfileDataView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 14.09.2025.
//


import SwiftUI

struct ProfileDataView: View {

    let url: URL?
    let name: String
    let email: String

    @Binding var isSignOutPresented: Bool

    var body: some View {
        VStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .fill(Color.secondary.opacity(0.25))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .padding(16)
                            .foregroundColor(.customLightBlue)
                    }
            }
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
            Text(email)
                .font(.body)
                .foregroundColor(.secondary.opacity(0.5))
            Button("Sign Out") {
                isSignOutPresented = true
            }
            .padding()
        }
    }
}
