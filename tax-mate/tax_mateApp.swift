//
//  tax_mateApp.swift
//  tax-mate
//
//  Created by Stephen Yao on 16/2/22.
//

import SwiftUI

@main
struct tax_mateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
