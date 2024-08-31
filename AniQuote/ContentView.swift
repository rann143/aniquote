//
//  ContentView.swift
//  AniQuote
//
//  Created by Daniel Roderman on 8/20/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        TabView {
            
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            
            FavoritesView()
                .tabItem{
                    Label("Favorites", systemImage: "heart")
                }
            
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
            
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


