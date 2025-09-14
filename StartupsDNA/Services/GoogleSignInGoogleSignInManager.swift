//
//  GoogleAuthManager.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 14.09.2025.
//


import SwiftUI
import GoogleSignIn
import FirebaseCore

final class GoogleAuthManager: ObservableObject {
    @Published var isSignedIn = false
    @Published var user: GIDGoogleUser?
    @Published var isErrorAlertPresented: Bool = false
    @Published var error: Error? {
        didSet {
            guard let error else {
                isErrorAlertPresented = false
                return
            }
            isErrorAlertPresented = true
        }
    }

    init() {
        setupGoogleSignIn()
    }
    
    private func setupGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("Firebase configuration missing")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    func signIn() {
        guard let rootViewController = UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first(where: { $0.isKeyWindow }).flatMap(\.rootViewController) else {
            assertionFailure("No root view controller")
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self else {return }
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                if let error = error {
                    self.error = error
                    return
                }
                guard let user = result?.user else { return }
                self.user = user
                self.isSignedIn = true
                self.error = nil
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        isSignedIn = false
        user = nil
    }
    
    func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self = self else { return }
            if let error = error as NSError? {
                if error.domain == "com.google.GIDSignIn" {
                    print("Google Sign-In restoration: \(error.code) - \(error.localizedDescription)")
                }
                return
            }
            DispatchQueue.main.async {
                self.user = user
                self.isSignedIn = user != nil
                if self.isSignedIn {
                    print("Previous session restored: \(user?.profile?.email ?? "No email")")
                }
            }
        }
    }
}
