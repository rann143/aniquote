//
//  HomeView.swift
//  AniQuote
//
//  Created by Daniel Roderman on 8/23/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    fileprivate func loadQuote() -> Task<(), Never> {
        return Task {
            do {
                try await viewModel.fetchQuote()
                //                  try await viewModel.fetchFact()
            } catch WError.invalidURL  {
                print("invalid URL")
            } catch WError.invalidResponse {
                print("invalid response")
            } catch WError.invalidData {
                print("invalid data")
            } catch {
                print("unexpected error: \(error.localizedDescription)")
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("AniQuote")
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Text("Daily Quote")
                .multilineTextAlignment(.center)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .bold()
                .dynamicTypeSize(/*@START_MENU_TOKEN@*/.xxxLarge/*@END_MENU_TOKEN@*/)
                .focused(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=$isFocused@*/FocusState<Bool>().projectedValue/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
            Spacer()
            Text(viewModel.newQuote?.quote ?? "Loading...").multilineTextAlignment(.center).padding(.all)
            if let speakerName = viewModel.newQuote?.author, !speakerName.isEmpty
            {
                Text("- \(speakerName)").padding(.all)
            }
            if let animeName = viewModel.newQuote?.anime, !animeName.isEmpty {
                Text("FROM: \(animeName)").padding(.all)
            }
            Text(viewModel.newFact?.fact ?? "").padding(.all)
            Spacer()
            Button("Get Quote", systemImage: "sun.horizon", action: {
                loadQuote()
            })
            Spacer()
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
        .task {
            loadQuote()
            }
    }


}


#Preview {
    HomeView()
}
