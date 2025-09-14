//
//  ProfileView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject var googleAuthManager: GoogleAuthManager

    @Binding var isSignedIn: Bool

    @State private var isSignOutPresented: Bool = false

    var body: some View {
        Group {
            if let user = googleAuthManager.user {
                ProfileDataView(
                    url: user.profile?.imageURL(withDimension: 100),
                    name: user.profile?.name ?? "No name",
                    email: user.profile?.email ?? "No email",
                    isSignOutPresented: $isSignOutPresented
                )
            } else {
                ProfileDataView(
                    url: nil,
                    name: "No name",
                    email: "No email",
                    isSignOutPresented: $isSignOutPresented
                )
            }
        }
        .navigationTitle("Profile")
        .onChange(of: googleAuthManager.isSignedIn) { newValue in
            isSignedIn = newValue
        }
        .alert(isPresented: $isSignOutPresented) {
            Alert(
                title: Text("Attension"),
                message: Text("Are you sure you want to sign out?"),
                primaryButton: .destructive(Text("Exit"), action: {
                    googleAuthManager.signOut()
                }),
                secondaryButton: .cancel({
                    isSignOutPresented = false
                })
            )
        }
    }
}

#Preview {
    ProfileView(googleAuthManager: GoogleAuthManager(), isSignedIn: .constant(false))
}
