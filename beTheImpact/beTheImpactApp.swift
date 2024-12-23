//
//  beTheImpactApp.swift
//  beTheImpact
//
//  Created by Raneem on 17/06/1446 AH.
//

//import SwiftUI
//
//@main
//struct YourAppName: App {
//    var body: some Scene {
//        WindowGroup {
//            OnboardingView1()
//        }
//    }
//}
import SwiftUI

@main
struct YourAppName: App {
    var body: some Scene {
        WindowGroup {
            // Pass a closure to OnboardingView1
            ContentView() // Use ContentView to manage the splash and onboarding transitions
        }
    }
}
