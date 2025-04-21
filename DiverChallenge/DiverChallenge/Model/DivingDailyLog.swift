//
//  DivingDailyLog.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI
import SwiftData

@Model
class DivingDailyLog {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    var createdAt: Date = Date()

    var todayGoal: String    // 오늘 목표
    var todayMoodRaw: String // 오늘 기분
    var todayNote: String?   // 오늘 한마디

    @Relationship var book: DivingBook

    // computed property로 enum처럼 다룸
    var todayMood: ModeType {
        get { ModeType(rawValue: todayMoodRaw) ?? .neutral }
        set { todayMoodRaw = newValue.rawValue }
    }

    init(date: Date, todayGoal: String, todayMood: ModeType, todayNote: String?, book: DivingBook) {
        self.date = date
        self.todayGoal = todayGoal
        self.todayMoodRaw = todayMood.rawValue
        self.todayNote = todayNote
        self.book = book
    }
}

