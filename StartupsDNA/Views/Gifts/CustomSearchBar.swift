//
//  CustomSearchBar.swift
//  StartupsDNA
//
//  Created by Alexander Ognerubov on 12.09.2025.
//


import SwiftUI

struct CustomSearchBar: View {

    @ObservedObject var viewModel: ViewModel
    @FocusState.Binding var isSearchFocused: Bool

    var body: some View {
        HStack {
            ZStack {
                TextField("", text: $viewModel.searchText)
                    .placeholder(when: viewModel.searchText.isEmpty && !isSearchFocused, placeholder: {
                        searchPlaceholder
                    })
                    .focused($isSearchFocused)
                    .textFieldStyle(.plain)
                    .font(.system(size: 17, weight: .regular))
                    .frame(maxWidth: .infinity, minHeight: 42, maxHeight: 42)
                    .padding(.leading, 12)
                    .padding(.trailing, isSearchFocused ? 32 : 12)
                    .background(.customWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                HStack {
                    Button(action: {
                        viewModel.searchText = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .opacity(0.5)
                    })
                    .tint(.customLightGray)
                    .padding(.trailing, 8)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .opacity(isSearchFocused ? 1 : 0)
            }
            if isSearchFocused {
                Button(action: {
                    isSearchFocused = false
                    viewModel.searchText = ""
                }, label: {
                    Text("Cancel")
                })
                .tint(.customDarkBlue)
            }
        }
        .frame(width: isSearchFocused ? .infinity : 110)
    }

    private var searchPlaceholder: some View {
        HStack(spacing: 8) {
            Image(.magnifier)
            Text("Search").font(.system(size: 17, weight: .regular)).foregroundColor(.customLightGray)
                .lineLimit(1)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}
