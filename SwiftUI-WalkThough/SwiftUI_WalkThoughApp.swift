//
//  SwiftUI_WalkThoughApp.swift
//  SwiftUI-WalkThough
//
//  Created by Waleerat Gottlieb on 2022-03-17.
//

import SwiftUI

@main
struct SwiftUI_WalkThoughApp: App {
    @AppStorage("isGoToLandingPage") private var isGoToLandingPage: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isGoToLandingPage {
                WelcomeView()
            } else {
                WalkthoughView()
            }
        }
    }
}
