//
//  LoginView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject private var viewModel: ViewModel

    init() {
        self.viewModel = ViewModel()
        setupAppearence()
    }

    // MARK: - Body
    var body: some View {
        Group {
            if !viewModel.isSignedInApple || viewModel.isSignedInGoogle {
                TabView {
                    GiftsView(viewModel: viewModel)
                        .tabItem({
                            VStack {
                                Image(.tabIconGifts)
                                Text("Gifts")
                                    .font(.system(size: 12, weight: .medium))
                            }
                        })
                        .tag(0)
                    ProfileView()
                        .tabItem({
                            VStack {
                                Image(.tabIconFlowers)
                                Text("Flowers")
                                    .font(.system(size: 12, weight: .medium))
                            }
                        })
                        .tag(1)
                    ProfileView()
                        .tabItem({
                            VStack {
                                Image(.tabIconEvents)
                                Text("Events")
                                    .font(.system(size: 12, weight: .medium))
                            }
                        })
                        .tag(2)
                    ProfileView()
                        .tabItem({
                            VStack {
                                Image(.tabIconCart)
                                Text("Cart")
                                    .font(.system(size: 12, weight: .medium))
                            }
                        })
                        .tag(3)
                    ProfileView()
                        .tabItem({
                            VStack {
                                Image(.tabIconProfile)
                                Text("Profile")
                                    .font(.system(size: 12, weight: .medium))
                            }
                        })
                        .tag(4)
                }
                .tint(.customDarkBlue)
            } else {
                NavigationView {
                    ZStack {
                        LoginView.background(.flowerBackground)
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
                }
            }
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
                action: { print("Apple") }
            )
            LoginButton(
                title: "Continue with Google",
                image: .googleLogo,
                action: { print("Google") }
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

    // MARK: - Methods
    private func setupAppearence() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "YFFRARETRIAL-AlphaBlack", size: 40)!,
            .foregroundColor: UIColor.customDarkBlue
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont(name: "YFFRARETRIAL-AlphaBlack", size: 64)!,
            .foregroundColor: UIColor.customDarkBlue
        ]
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().unselectedItemTintColor = UIColor.customInavtive
        UITabBar.appearance().barTintColor = UIColor.customWhite
    }
}

extension LoginView {
    static func background(_ imageResource: ImageResource?) -> some View {
        Rectangle()
            .fill(.customLightBlue)
            .ignoresSafeArea()
            .overlay {
                if let imageResource {
                    Image(imageResource)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .offset(y: 55)
                }
            }
    }
}

#Preview {
    LoginView()
}
