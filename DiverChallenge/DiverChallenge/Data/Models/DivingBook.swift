//
//  DivingBook.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI
import SwiftData

@Model
class DivingBook {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String              // 도감 제목
    var goal: String               // 도감 목표
    var startDate: Date            // 시작 날짜
    var endDate: Date              // 종료 날짜
    var createdAt: Date = Date()   // 현재 날짜
    
    var imageIndex: Int = Int.random(in: 1...6)            // 도감 이미지
    
    @Relationship(deleteRule: .cascade) var dailyLogs: [DivingDailyLog] = []

    init(title: String, goal: String, startDate: Date, endDate: Date) {
        self.title = title
        self.goal = goal
        self.startDate = startDate
        self.endDate = endDate
    }
}
