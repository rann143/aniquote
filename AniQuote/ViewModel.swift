//
//  ViewModel.swift
//  AniQuote
//
//  Created by Daniel Roderman on 8/30/24.
//

import SwiftUI
import Combine
import Foundation

struct AnimeQuote: Codable {
    let _id: Int
    let quote: String
    let anime: String
    let author: String
}

struct AnimeFact: Codable {
    let _id: Int
    let tags: [String]
    let fact: String
}

class ViewModel: ObservableObject {
    // Published properties to trigger UI updates when changed
    @Published var newQuote: AnimeQuote?
    @Published var newFact: AnimeFact?
    
    private var accessToken = "MTE4NDIyNTg0NTg5MjYxMjI2Nw--.MTcyNTA2MDYwMA--.0bb12efe88"
    
    func fetchQuote() async throws {
        let endpoint = "https://waifu.it/api/v4/quote"
        guard let url = URL(string: endpoint) else {
            throw WError.invalidURL
        }

        var req = URLRequest(url: url)
        req.setValue("\(accessToken)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                
                // Log the raw data response for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(jsonString)")
                }
                
                // Check for non-successful status code
                if !(200...299).contains(httpResponse.statusCode) {
                    throw WError.invalidResponse
                }
            }

            do {
                let decoder = JSONDecoder()
                self.newQuote = try decoder.decode(AnimeQuote.self, from: data)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                throw WError.invalidData
            }
        } catch {
            print("Network error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchFact() async throws {
        let endpoint = "https://waifu.it/api/v4/fact"
        guard let url = URL(string: endpoint) else {
            throw WError.invalidURL
        }

        var req = URLRequest(url: url)
        req.setValue("\(accessToken)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: req)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                
                // Log the raw data response for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(jsonString)")
                }
                
                // Check for non-successful status code
                if !(200...299).contains(httpResponse.statusCode) {
                    throw WError.invalidResponse
                }
            }

            do {
                let decoder = JSONDecoder()
                self.newFact = try decoder.decode(AnimeFact.self, from: data)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                throw WError.invalidData
            }
        } catch {
            print("Network error: \(error.localizedDescription)")
            throw error
        }
    }
}

enum WError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
