//
//  CollectionsView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//


import SwiftUI

struct CollectionsView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        LazyHStack {
            ForEach(viewModel.collections) { collection in
                NavigationLink(destination: {
                    InProgressView()
                }, label: {
                    VStack(spacing: 0) {

                        Image(uiImage: UIImage(named: collection.image) ?? UIImage.checkmark)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .cornerRadius(12)
                            .padding(.top, 6)
                        Text(collection.title)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.customDarkBlue)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 7.5)
                            .padding(.top, 5)

                    }
                    .frame(width: 100, height: 120, alignment: .top)
                })
            }
            Button(action: {
                print("Show all pressed")
            }, label: {
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(maxHeight: .infinity)
                    Text("Show all")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.customDarkBlue)
                        .fixedSize()
                }
            })
        }
        .padding(.top, 10)
        .padding(.horizontal, 16)
    }
}
