//
//  BannersView.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//


import SwiftUI

struct BannersView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        LazyHStack(spacing: 5) {
            ForEach(viewModel.banners) { banner in
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(uiColor: UIColor(named: banner.primaryColor) ?? UIColor.black))
                        .frame(width: 350, height: 150)
                        .overlay(content: {
                            Image(uiImage: UIImage(named: banner.image) ?? UIImage.checkmark)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .cornerRadius(16)
                        })
                    VStack {
                        Text(banner.title)
                            .font(.custom("YFFRARETRIAL-AlphaBlack", size: 40))
                            .foregroundColor(Color(uiColor: UIColor(named: banner.secondaryColor) ?? UIColor.black))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            NavigationLink(destination: {
                                InProgressView()
                            }, label: {
                                Text(banner.action)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 5)
                                    .background(.customWhite)
                                    .cornerRadius(16)
                            })
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(18)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
