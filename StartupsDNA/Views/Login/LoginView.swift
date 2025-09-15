//
//  LoginView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 14.09.2025.
//


import SwiftUI

struct LoginView: View {

    @ObservedObject var googleAuthManager: GoogleAuthManager

    @Binding var isSignedIn: Bool

    // MARK: - Body
    var body: some View {
        ZStack {
            ContentView.background(.flowerBackground)
            VStack(spacing: 0) {
                subtitle
                mainImage
                loginButtons
                termsAndPolicy
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: { toolBarButton })
            }
            .navigationTitle("WELCOME")
        }
        .onChange(of: googleAuthManager.isSignedIn) { newValue in
            isSignedIn = newValue
        }
    }

    // MARK: - Views
    private var subtitle: some View {
        Text("Enter your phone number. We will send you an SMS with a confirmation code to this number.")
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(.customLightGray)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 10)
    }

    private var mainImage: some View {
        Image(.flower)
            .frame(width: 171, height: 285)
            .scaledToFit()
            .padding(.top, 55)
            .padding(.bottom, 9)
    }

    private var loginButtons: some View {
        VStack(spacing: 8) {
            LoginButton(
                title: "Continue with Apple",
                image: .appleLogo,
                action: { print("Apple login develop in progress.") }
            )
            LoginButton(
                title: "Continue with Google",
                image: .googleLogo,
                action: { googleAuthManager.signIn() }
            )
        }
        .padding([.horizontal, .bottom], 16)
    }

    private var termsAndPolicy: some View {
        Group {
            Text("By continuing, you agree to Assetsy’s")
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(.customLightGray)
            HStack {
                Button(action: {
                    print("Terms of use")
                }, label: {
                    Text("Terms of use")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.customLink)
                        .underline()
                })
                Text("and")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.customLightGray)
                Button(action: {
                    print("Privacy Policy")
                }, label: {
                    Text("Privacy Policy")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.customLink)
                        .underline()
                })
            }
        }
    }

    private var toolBarButton: some View {
        Button(action: {
            print("no action")
        }, label: {
            Text("Skip")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.customDarkBlue)
        })
    }
}

#Preview {
    struct PreviewStruct: View {
        @ObservedObject var googleAuthManager = GoogleAuthManager()

        init() {
            ContentView.setupAppearence()
        }

        var body: some View {
            NavigationView {
                LoginView(googleAuthManager: googleAuthManager, isSignedIn: .constant(false))
            }
        }
    }

    return PreviewStruct()
}
