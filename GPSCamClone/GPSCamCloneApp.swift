//
//  GPSCamCloneApp.swift
//  GPSCamClone
//
//  Created by Bhanu Sharma on 06/03/25.
//

import SwiftUI

@main
struct GPSCamCloneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
