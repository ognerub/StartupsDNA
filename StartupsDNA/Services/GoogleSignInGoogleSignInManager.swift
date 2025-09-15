//
//  GoogleAuthManager.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 14.09.2025.
//


import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

final class GoogleAuthManager: ObservableObject {
    // MARK: Properties
    @Published var isSignedIn = false
    @Published var isLoading = false
    @Published var user: GIDGoogleUser?
    @Published var isErrorAlertPresented: Bool = false
    @Published var error: Error? {
        didSet {
            guard error != nil else {
                isErrorAlertPresented = false
                return
            }
            isErrorAlertPresented = true
        }
    }

    private let networkService = NetworkService()
    private let userDefaultsManager = UserDefaultsManager()

    // MARK: Init
    init() {
        setupGoogleSignIn()
    }

    // MARK: Public methods
    func signIn() {
        guard let rootViewController = UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first(where: { $0.isKeyWindow }).flatMap(\.rootViewController) else {
            assertionFailure("No root view controller")
            return
        }
        self.isLoading = true
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                self.error = error
                return
            }
            guard let user = result?.user else { return }
            self.user = user
            self.error = nil
            self.authenticateWithFirebase(googleUser: user)
        }

    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        isSignedIn = false
        user = nil
        isLoading = false
    }

    func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self, let user else { return }
            if let error = error as NSError? {
                if error.domain == "com.google.GIDSignIn" {
                    print("Google Sign-In restoration: \(error.code) - \(error.localizedDescription)")
                }
                return
            }
            self.user = user
            self.error = nil
            if self.userDefaultsManager.serverToken != nil {
                DispatchQueue.main.async {
                    self.isSignedIn = true
                }
            } else {
                self.isLoading = true
                self.authenticateWithFirebase(googleUser: user)
            }
        }
    }
}

private extension GoogleAuthManager {
    func setupGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("Firebase configuration missing")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }

    func authenticateWithFirebase(googleUser: GIDGoogleUser) {
        guard let idToken = googleUser.idToken?.tokenString else {
            DispatchQueue.main.async { [weak self] in
                self?.error = NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "No ID token from Google"])
                self?.isLoading = false
            }
            return
        }
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: googleUser.accessToken.tokenString
        )
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error {
                DispatchQueue.main.async {
                    self?.error = error
                    self?.isLoading = false
                }
                return
            }
            self?.getFirebaseIdToken()
        }
    }

    func getFirebaseIdToken() {
        Auth.auth().currentUser?.getIDToken(completion: { [weak self] token, error in
            if let error {
                DispatchQueue.main.async {
                    self?.error = error
                    self?.isLoading = false
                }
                return
            }
            if let token {
                self?.getServerToken(using: token)

            }
        })
    }

    func getServerToken(using firebaseToken: String) {
        networkService.getToken(firebaseToken: firebaseToken) { result in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                switch result {
                case .success(let token):
                    self?.userDefaultsManager.serverToken = token.result.accessToken
                    self?.isSignedIn = true
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
