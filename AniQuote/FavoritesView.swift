//
//  FavoritesView.swift
//  AniQuote
//
//  Created by Daniel Roderman on 8/23/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        VStack {
            Text("AniQuote")
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Text("Favorites")
                .multilineTextAlignment(.center)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .bold()
                .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxxLarge/*@END_MENU_TOKEN@*/)
                .focused(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=$isFocused@*/FocusState<Bool>().projectedValue/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("These are my favorite quotes & facts")
            Spacer()
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.orange)
    }
}

#Preview {
    FavoritesView()
}
