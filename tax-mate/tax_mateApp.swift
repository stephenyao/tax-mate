//
//  tax_mateApp.swift
//  tax-mate
//
//  Created by Stephen Yao on 16/2/22.
//

import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Create seed data
#if DEBUG
        let seeded = UserDefaults.standard.bool(forKey: "seeded")
        if !seeded {
            SeedDb.populate()
            UserDefaults.standard.set(true, forKey: "seeded")
        }
#endif
        
        return true
    }
    
}

@main
struct tax_mateApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isPresented = true
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
    
}
