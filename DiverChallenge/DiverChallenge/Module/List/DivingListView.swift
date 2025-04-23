//
//  DivingListView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI
import SwiftData

struct DivingListView: View {
    /// 도감 모델
    let book: DivingBook
    
    /// SwiftData 컨텍스트
    @Environment(\.modelContext) private var context
    
    /// 네비게이션 back 버튼을 위한 환경 변수
    @Environment(\.dismiss) private var dismiss
    
    /// 새로운 다이빙 로그 만들 때 필요한 상태 변수
    @State private var selectedLog: DivingDailyLog?
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                title: "다이빙 리스트",
                rightButtonImage: Image(systemName: "plus"),
                rightButtonAction: {
                    createNewLog()
                }
            )
            
            VStack(alignment: .leading, spacing: 20) {
                // 다이빙 제목
                Text(book.title)
                    .font(.pretendard(type: .bold, size: 32))
                    .foregroundStyle(.black)
                
                // 전체 목표 + 남은 디데이
                HStack {
                    Label {
                        Text(book.goal)
                            .font(.pretendard(type: .semibold, size: 16))
                    } icon: {
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.main)
                    }
                    
                    Spacer()
                    
                    Text("\(daysRemaining)일 남음")
                        .font(.pretendard(type: .semibold, size: 16))
                }
                
                // 다이빙 리스트
                List {
                    ForEach(book.dailyLogs.sorted(by: { $0.date < $1.date })) { log in
                        NavigationLink(destination: DivingLogView(log: log)) {
                            logList(for: log)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        .listRowBackground(Color.clear)
                    }
                    
                    .onDelete(perform: deleteLog)
                }
                .listStyle(.plain)
            }
            .padding(.horizontal, 16)
            .navigationBarHidden(true)
            .navigationDestination(item: $selectedLog) { log in
                DivingLogView(log: log, isNew: true)
            }
        }
    }
    
    /// 로그 리스트 뷰
    private func logList(for log: DivingDailyLog) -> some View {
        let isDone = log.isDone
        
        return VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Day \(dayNumber(for: log))")
                            .font(.pretendard(type: .semibold, size: 24))
                            .foregroundStyle(isDone ? .white : .black)
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(isDone ? .white : .clear)
                    }
                    Text(log.todayGoal)
                        .font(.pretendard(type: .semibold, size: 16))
                        .foregroundStyle(isDone ? .white : .black)
                }
                
                Spacer()
                
                Text(log.todayMood.mood)
                    .foregroundStyle(isDone ? .white : .main)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isDone ? Color.main : .white)
                    .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 2)
            )
        }
    }
    
    /// 새 로그 생성
    private func createNewLog() {
        selectedLog = DivingDailyLog(
            date: Date(),
            todayGoal: "",
            todayMood: .neutral,
            todayNote: nil,
            book: book
        )
    }
    
    /// 삭제
    private func deleteLog(at offsets: IndexSet) {
        for index in offsets {
            let log = book.dailyLogs.sorted(by: { $0.date < $1.date })[index]
            context.delete(log)
        }
        try? context.save()
    }
    
    /// 날짜 계산
//    private var daysRemaining: Int {
//        Calendar.current.dateComponents([.day], from: Date(), to: book.endDate).day ?? 0
//    }
    private var daysRemaining: Int {
        let now = Calendar.current.startOfDay(for: Date())
        let end = Calendar.current.startOfDay(for: book.endDate)
        return Calendar.current.dateComponents([.day], from: now, to: end).day ?? 0
    }
    
    /// 디데이
//    private func dayNumber(for log: DivingDailyLog) -> Int {
//        Calendar.current.dateComponents([.day], from: book.startDate, to: log.date).day.map { $0 + 1 } ?? 1
//    }
    private func dayNumber(for log: DivingDailyLog) -> Int {
        let start = Calendar.current.startOfDay(for: book.startDate)
        let logDate = Calendar.current.startOfDay(for: log.date)
        
        let diff = Calendar.current.dateComponents([.day], from: start, to: logDate).day ?? 0
        return diff + 1 // Day 1부터 시작
    }
}

#Preview {
    let schema = Schema([DivingBook.self, DivingDailyLog.self])
    let container = try! ModelContainer(for: schema, configurations: [])

    let context = container.mainContext

    let book = DivingBook(
        title: "챌린지 예시",
        goal: "디자인 다듬기",
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    )

    let log1 = DivingDailyLog(
        date: Date(),
        todayGoal: "버튼 디자인 완성",
        todayMood: .happy,
        todayNote: "기분 좋게 마무리",
        book: book
    )

    let log2 = DivingDailyLog(
        date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        todayGoal: "UI 컴포넌트 정리",
        todayMood: .neutral,
        todayNote: "그럭저럭 했음",
        book: book
    )

    log1.isDone = true
    book.dailyLogs = [log1, log2]

    context.insert(book)
    context.insert(log1)
    context.insert(log2)

    return DivingListView(book: book)
        .modelContainer(container)
}

