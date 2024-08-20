//
//  AniQuoteApp.swift
//  AniQuote
//
//  Created by Daniel Roderman on 8/20/24.
//

import SwiftUI

@main
struct AniQuoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
