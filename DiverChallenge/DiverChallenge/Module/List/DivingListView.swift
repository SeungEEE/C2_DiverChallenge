//
//  DivingListView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI
import SwiftData

struct DivingListView: View {
    let book: DivingBook
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedLog: DivingDailyLog?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // 다이빙 제목
            Text(book.title)
                .font(.pretendard(type: .bold, size: 32))
                .foregroundStyle(.main)
            
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
                }
                
                .onDelete(perform: deleteLog)
            }
            .listStyle(.plain)
        }
        .padding(.horizontal, 16)
        /// 네비게이션
        .navigationTitle("다이빙 리스트")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // 커스텀 back
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }

            // + 버튼
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    createNewLog()
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationDestination(isPresented: Binding(
            get: { selectedLog != nil },
            set: { isActive in if !isActive { selectedLog = nil } }
        )) {
            if let selectedLog {
                DivingLogView(log: selectedLog)
            }
        }
    }
    
    /// 로그 리스트 뷰
    private func logList(for log: DivingDailyLog) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Day \(dayNumber(for: log))")
                        .font(.pretendard(type: .semibold, size: 24))
                        .foregroundStyle(.main)
                    Text(log.todayGoal)
                        .font(.pretendard(type: .semibold, size: 16))
                        .foregroundStyle(.main)
                }
                
                Spacer()
                
                Text(log.todayMood.mood)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 2)
            )
        }
    }
    
    // MARK: - 새 로그 생성
    private func createNewLog() {
        let newLog = DivingDailyLog(
            date: Date(),
            todayGoal: "",
            todayMood: .neutral,
            todayNote: nil,
            book: book
        )
        book.dailyLogs.append(newLog)
        context.insert(newLog)
        try? context.save()
        selectedLog = newLog
    }
    
    // MARK: - 삭제
    private func deleteLog(at offsets: IndexSet) {
        for index in offsets {
            let log = book.dailyLogs.sorted(by: { $0.date < $1.date })[index]
            context.delete(log)
        }
        try? context.save()
    }
    
    // MARK: - 날짜 계산
    private var daysRemaining: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: book.endDate).day ?? 0
    }
    
    private func dayNumber(for log: DivingDailyLog) -> Int {
        Calendar.current.dateComponents([.day], from: book.startDate, to: log.date).day.map { $0 + 1 } ?? 1
    }
}

#Preview {
    let schema = Schema([DivingBook.self, DivingDailyLog.self])
    let container = try! ModelContainer(for: schema, configurations: [])
    
    let context = container.mainContext
    
    let sampleBook = DivingBook(
        title: "Challenge 2",
        goal: "디자인 야무지게 하기",
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 20, to: Date())!
    )
    
    let log1 = DivingDailyLog(
        date: Calendar.current.date(byAdding: .day, value: 0, to: sampleBook.startDate)!,
        todayGoal: "하루 세끼 잘 먹기",
        todayMood: .happy,
        todayNote: "오늘은 기분이 좋아요!",
        book: sampleBook
    )
    
    let log2 = DivingDailyLog(
        date: Calendar.current.date(byAdding: .day, value: 1, to: sampleBook.startDate)!,
        todayGoal: "포토샵 튜토리얼 끝내기",
        todayMood: .neutral,
        todayNote: "그럭저럭 했음",
        book: sampleBook
    )
    
    sampleBook.dailyLogs = [log1, log2]
    
    context.insert(sampleBook)
    context.insert(log1)
    context.insert(log2)
    
    return DivingListView(book: sampleBook)
        .modelContainer(container)
}
