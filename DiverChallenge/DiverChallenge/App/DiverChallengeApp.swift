//
//  DiverChallengeApp.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI
import SwiftData

@main
struct DiverChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(for: [DivingBook.self, DivingDailyLog.self])
    }
}
