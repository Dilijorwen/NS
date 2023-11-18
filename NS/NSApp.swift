//
//  NSApp.swift
//  NS
//
//  Created by Даниил on 18.11.2023.
//

import SwiftUI

@main
struct NSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
