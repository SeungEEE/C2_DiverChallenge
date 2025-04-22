//
//  DivingLogView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI
import SwiftData

struct DivingLogView: View {
    @Bindable var log: DivingDailyLog
    @Environment(\.modelContext) private var modelContext
    
    /// 텍스트필드 선택시 Focus해주기 위한 상태 변수
    @FocusState private var goalIsFocused: Bool
    @FocusState private var wordIsFocused: Bool
    
    @State private var goal: String
    @State private var word: String
    
    /// 선택된 아이템 종류를 저장하는 상태 변수
    @State private var newModeType: ModeType
    
    /// 초기 상태로 세팅
    init(log: DivingDailyLog) {
        self._log = Bindable(wrappedValue: log)
        self._goal = State(initialValue: log.todayGoal)
        self._word = State(initialValue: log.todayNote ?? "")
        self._newModeType = State(initialValue: log.todayMood)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            TopView
            
            goalView
            
            wordView
            
            moodView
            
            bottomView
        }
        .safeAreaPadding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
        .navigationTitle(log.book.title)
    }
    
    /// 전체 목표 + 남은 날짜를 보여주는 뷰
    private var TopView: some View {
        VStack {
            HStack {
                Label {
                    Text(log.book.goal)
                        .font(.pretendard(type: .semibold, size: 30))
                    
                } icon: {
                    Image(systemName: "rosette")
                        .resizable()
                        .frame(width: 24, height: 30)
                }
                .foregroundStyle(.main)
                
                Spacer()
                
                Text("Day \(dayNumber)")
                    .font(.pretendard(type: .semibold, size: 16))
                    .foregroundStyle(.main)
                    .offset(y: 10)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 3)
                .foregroundStyle(.main)
            
        }
    }
    
    /// 오늘의 목표를 보여주는 뷰 Text + TextField
    private var goalView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🏆 오늘의 목표")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.main)
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "square")
                        .foregroundStyle(.gray01)
                }
                
                TextField("오늘의 목표는 무엇인가요?", text: $goal)
                    .padding(.vertical, 8)
                    .focused($goalIsFocused)
                    .overlay (
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(goalIsFocused ? .main : .gray01),
                        alignment: .bottom
                    )
            }
            
            Divider()
        }
    }
    
    /// 오늘의 한마디를 보여주는 뷰 Text + TextField
    private var wordView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("💬 오늘의 한마디")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.main)
            
            ZStack(alignment: .topLeading) {
                if word.isEmpty {
                    Text("오늘의 하루 어떠셨나요?")
                        .foregroundColor(.gray01)
                        .font(.pretendard(type: .medium, size: 16))
                        .padding(.vertical, 16)
                        .padding(.horizontal, 12)
                }
                
                TextEditor(text: $word)
                    .focused($wordIsFocused)
                    .frame(minHeight: 150)
                    .padding(8)
                    .background(Color.clear)
                    .textEditorStyle(.plain)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(wordIsFocused ? Color.main : Color.gray01, lineWidth: 1)
                    )
            }
            
            Divider()
                .padding(.top, 16)
        }
    }
    
    /// 오늘의 기분을 선택할 수 있는 뷰
    private var moodView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("😀 오늘의 기분")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.main)
            
            // 기분 선택 Picker
            Picker("무드 종류", selection: $newModeType) {
                ForEach(ModeType.allCases, id: \.self) { type in
                    Text("\(type.mood)")
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 3)
                .foregroundStyle(.main)
        }
    }
    
    /// 오늘 날짜 + 저장하기 버튼
    private var bottomView: some View {
        VStack(alignment: .trailing) {
            Text(formattedDate)
                .font(.pretendard(type: .semibold, size: 16))
            
            Spacer()
            
            MainButton(buttonType: .save) {
                log.todayGoal = goal
                log.todayNote = word
                log.todayMood = newModeType
                
                try? modelContext.save()
            }
        }
    }
    
    // MARK: - 날짜/Day 계산 함수
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: log.date)
    }
    
    private var dayNumber: Int {
        Calendar.current.dateComponents([.day], from: log.book.startDate, to: log.date).day.map { $0 + 1 } ?? 1
    }
}

#Preview {
    let schema = Schema([DivingDailyLog.self, DivingBook.self])
    let container = try! ModelContainer(for: schema)
    
    let book = DivingBook(
        title: "Challenge 2",
        goal: "디자인 야무지게 하기",
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!
    )
    
    let log = DivingDailyLog(
        date: Date(),
        todayGoal: "하루 목표",
        todayMood: .happy,
        todayNote: "오늘은 기분이 좋아요!",
        book: book
    )
    
    container.mainContext.insert(book)
    container.mainContext.insert(log)
    
    return DivingLogView(log: log)
        .modelContainer(container)
}
