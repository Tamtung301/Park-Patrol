//
//  Park_PatrolApp.swift
//  Park Patrol
//
//  Created by Hector Mojica on 11/27/24.
//

import SwiftUI

@main
struct Park_PatrolApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
