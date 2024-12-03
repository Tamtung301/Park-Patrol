//
//  ParkPatrolApp.swift
//  Park Patrol
//
//  Created by Hector Mojica on 11/27/24.
//


import SwiftUI

@main
struct ParkPatrolApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
