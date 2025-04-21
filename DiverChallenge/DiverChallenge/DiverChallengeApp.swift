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
            ContentView()
        }
        .modelContainer(for: [DivingBook.self, DivingDailyLog.self])
    }
}
