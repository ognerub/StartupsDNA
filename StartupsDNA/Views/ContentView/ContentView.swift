//
//  ContentView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel: ViewModel
    @ObservedObject private var googleAuthManager: GoogleAuthManager

    init() {
        self.viewModel = ViewModel()
        self.googleAuthManager = GoogleAuthManager()
        ContentView.setupAppearence()
    }

    // MARK: Body
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            Group {
                if viewModel.isSignedIn {
                    tabView
                } else {
                    LoginView(
                        googleAuthManager: googleAuthManager,
                        isSignedIn: $viewModel.isSignedIn
                    )
                }
            }
        }
    }

    // MARK: Views
    private var tabView: some View {
        TabView {
            GiftsView(viewModel: viewModel)
                .tabItem({ tabItem(image: .tabIconGifts, name: "Gifts") })
                .tag(0)
            InProgressView()
                .tabItem({ tabItem(image: .tabIconFlowers, name: "Flowers") })
                .tag(1)
            InProgressView()
                .tabItem({ tabItem(image: .tabIconEvents, name: "Events") })
                .tag(2)
            InProgressView()
                .tabItem({ tabItem(image: .tabIconCart, name: "Cart") })
                .tag(3)
            ProfileView(googleAuthManager: googleAuthManager, isSignedIn: $viewModel.isSignedIn)
                .tabItem({ tabItem(image: .tabIconProfile, name: "Profile") })
                .tag(4)
        }
        .tint(.customDarkBlue)
    }

    // MARK: Methods
    private func tabItem(image: ImageResource,name: LocalizedStringKey) -> some View {
        VStack {
            Image(image)
            Text(name)
                .font(.system(size: 12, weight: .medium))
        }
    }
}

// MARK: - Static methods
extension ContentView {
    static func setupAppearence() {
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "YFFRARETRIAL-AlphaBlack", size: 40)!,
            .foregroundColor: UIColor.customDarkBlue
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont(name: "YFFRARETRIAL-AlphaBlack", size: 64)!,
            .foregroundColor: UIColor.customDarkBlue
        ]
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .customWhite
        tabBarAppearance.backgroundEffect = nil
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().unselectedItemTintColor = UIColor.customInavtive
    }

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
    ContentView()
}
