//
//  CategoriesView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 14.09.2025.
//


import SwiftUI

struct CategoriesView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 0) {
            allCeteroriesButton
            .padding(.top, 18)
            categoriesFilters
            .padding(16)
            categoriesCards
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity)
        .background(.customWhite)
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    private var allCeteroriesButton: some View {
        Button(action: {
            print("All categories pressed")
        }, label: {
            Text("View all categories")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.customDarkBlue)
                .frame(height: 32)
                .padding(.horizontal, 12)
        })
        .overlay {
            RoundedRectangle(cornerRadius: 23)
                .stroke(Color.customGray.opacity(0.5), lineWidth: 1)
                .padding(1)
                .foregroundColor(.clear)
        }
    }

    private var categoriesFilters: some View {
        HStack(spacing: 6) {
            Button(action: {
                print("Giftboxes pressed")
            }, label: {
                Text("\(Text("Giftboxes")) \(Image(systemName: "chevron.down"))")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.customDarkBlue)
                    .frame(maxWidth: .infinity, minHeight: 32, maxHeight: 32)
            })
            .background(.customLightBlue)
            .cornerRadius(23)
            Button(action: {
                print("For Her pressed")
            }, label: {
                Text("\(Text("For Her")) \(Image(systemName: "chevron.down"))")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.customDarkBlue)
                    .frame(maxWidth: .infinity, minHeight: 32, maxHeight: 32)
            })
            .background(.customLightBlue)
            .cornerRadius(23)
            Button(action: {
                print("Popular pressed")
            }, label: {
                Text("\(Text("Popular")) \(Image(systemName: "chevron.down"))")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.customDarkBlue)
                    .frame(maxWidth: .infinity, minHeight: 32, maxHeight: 32)
            })
            .background(.customLightBlue)
            .cornerRadius(23)
        }
    }

    private var categoriesCards: some View {
        LazyVGrid(columns: [
            GridItem(spacing: 6),
            GridItem()
        ], content: {
            ForEach(viewModel.categories) { category in
                NavigationLink(destination: {
                    InProgressView()
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 156)
                            .overlay {
                                Image(uiImage: UIImage(named: category.image) ?? UIImage.checkmark)
                                    .resizable()
                                    .scaledToFill()
                            }
                            .cornerRadius(12)
                        HStack {
                            Button(action: {
                                viewModel.toggleFavoriteCategory(category)
                            }, label: {
                                Group {
                                    if !category.isFavorite {
                                        Image(.heartIcon)
                                    } else {
                                        Image(systemName: "heart.fill")
                                    }
                                }
                                    .frame(width: 24, height: 24)
                                    .background(category.isFavorite ? .customWhite : .customBlack.opacity(0.5))
                                    .cornerRadius(24)
                            })
                            .tint(!category.isFavorite ? .customWhite : .customDeepRose)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(10)
                    }
                })
            }
        })
    }
}

#Preview {
    struct PreviewStruct: View {
        @ObservedObject var viewModel = ViewModel()
        @State var path = [String]()

        var body: some View {
            NavigationView {
                ScrollView {
                    CategoriesView(viewModel: viewModel)
                }
            }
        }
    }

    return PreviewStruct()
}
