//
//  GiftsView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//

import SwiftUI

struct GiftsView: View {

    @ObservedObject private var viewModel: ViewModel
    @FocusState private var isSearchFocused: Bool
    @State private var isNavigationBarHidden = false

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        setupAppearence()
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            ContentView.background(nil)
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 12) {
                        deliverTo
                        titleWithSearch
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        BannersView(viewModel: viewModel)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        CollectionsView(viewModel: viewModel)
                    }
                    ScrollView(.vertical, showsIndicators: false) {
                        CategoriesView(viewModel: viewModel)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Views
    private var deliverTo: some View {
        HStack {
            Text("Deliver to")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.customDarkBlue)
            Text(viewModel.selectedCurrency.flag)
                .font(.system(size: 32))
                .foregroundColor(.customDarkBlue)
            Menu(content: {
                ForEach(Currency.allCases, id: \.self) { value in
                    Button(value.rawValue, action: { viewModel.selectedCurrency = value })
                }
            }, label: {
                Text("\(Text(viewModel.selectedCurrency.rawValue)) \(Image(systemName: "chevron.down"))")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.customDarkBlue)
            })
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 16)
    }

    private var titleWithSearch: some View {
        HStack {
            if !isSearchFocused {
                Text("GIFTS")
                    .font(.custom("YFFRARETRIAL-AlphaBlack", size: 64))
                    .foregroundColor(.customDarkBlue)
                Spacer()
            }
            CustomSearchBar(viewModel: viewModel, isSearchFocused: $isSearchFocused)
        }
        .frame(height: 55)
        .animation(.easeInOut(duration: 0.3), value: isSearchFocused)
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
    }
}

#Preview {
    GiftsView(viewModel: ViewModel())
}
