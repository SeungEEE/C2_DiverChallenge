//
//  DivingLogView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI
import SwiftData

struct DivingLogView: View {
    /// SwiftData 바인딩 (양방향)
    @Bindable var log: DivingDailyLog
    
    /// SwiftData 컨텍스트
    @Environment(\.modelContext) private var modelContext
    
    /// 네비게이션 back 버튼 위한 환경 변수
    @Environment(\.dismiss) private var dismiss
    
    /// 새로운 도감인지 판단
    let isNew: Bool
    
    /// 텍스트필드 선택시 Focus해주기 위한 상태 변수
    @FocusState private var goalIsFocused: Bool
    @FocusState private var wordIsFocused: Bool
    
    /// 오늘의 목표
    @State private var goal: String
    
    /// 오늘의 한마디
    @State private var word: String
    
    /// 선택된 아이템 종류를 저장하는 상태 변수
    @State private var newModeType: ModeType
    
    /// 체크 버튼 클릭 상태 저장하는 변수
    @State private var isChecked: Bool
    
    /// 초기 상태로 세팅
    init(log: DivingDailyLog, isNew: Bool = false) {
        self._log = Bindable(wrappedValue: log)
        self._goal = State(initialValue: log.todayGoal)
        self._word = State(initialValue: log.todayNote ?? "")
        self._newModeType = State(initialValue: log.todayMood)
        self.isNew = isNew
        self._isChecked = State(initialValue: log.isDone)
    }
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                title: "다이빙 로그",
                showBackButton: true
            )
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    TopView
                    
                    goalView
                    
                    wordView
                    
                    moodView
                    
                    bottomView
                }
                .safeAreaPadding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
                
            }
            .hideKeyboardOnTap()
        }
        .navigationBarHidden(true)
    }
    
    /// 전체 목표 + 남은 날짜를 보여주는 뷰
    private var TopView: some View {
        VStack {
            HStack {
                Label {
                    Text(log.book.goal)
                        .font(.pretendard(type: .semibold, size: 28))
                    
                } icon: {
                    Text("📌")
                        .font(.system(size: 28))
                }
                .foregroundStyle(.black)
                
                Spacer()
                
                Text("Day \(dayNumber)")
                    .font(.pretendard(type: .semibold, size: 18))
                    .foregroundStyle(.main)
                    .offset(y: 10)
                
            }
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .foregroundStyle(.navy01)
        }
    }
    
    /// 오늘의 목표를 보여주는 뷰 Text + TextField
    private var goalView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🏆 오늘의 목표")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.black)
            
            HStack {
                Button {
                    isChecked.toggle()
                } label: {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .foregroundStyle(isChecked ? .main : .gray01)
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
                .foregroundStyle(.black)
            
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
                            .stroke(wordIsFocused ? .main : Color.gray01, lineWidth: 1)
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
                .foregroundStyle(.black)
            
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
                .frame(height: 1)
                .foregroundStyle(.navy01)
        }
    }
    
    /// 오늘 날짜 + 저장하기 버튼
    private var bottomView: some View {
        VStack(alignment: .trailing, spacing: 30) {
            Text(formattedDate)
                .font(.pretendard(type: .semibold, size: 16))
                .foregroundStyle(.navy01)
            
            MainButton(buttonType: .save) {
                log.todayGoal = goal
                log.todayNote = word
                log.todayMood = newModeType
                log.isDone = isChecked
                
                if isNew {
                    modelContext.insert(log)
                    log.book.dailyLogs.append(log)
                }
                
                try? modelContext.save()
                dismiss()
            }
        }
    }
    
    /// 날짜/Day 계산 함수
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: log.date)
    }
    
    /// 디데이
    private var dayNumber: Int {
        let start = Calendar.current.startOfDay(for: log.book.startDate)
        let target = Calendar.current.startOfDay(for: log.date)
        
        let diff = Calendar.current.dateComponents([.day], from: start, to: target).day ?? 0
        return diff + 1 // Day 1부터 시작
    }
}

#Preview {
    let schema = Schema([DivingDailyLog.self, DivingBook.self])
    let container = try! ModelContainer(for: schema)
    
    let book = DivingBook(
        title: "Challenge 2",
        goal: "집에 가기",
        startDate: Date(),
        endDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!
    )
    
    let log = DivingDailyLog(
        date: Date(),
        todayGoal: "집에 일찍 가기",
        todayMood: .happy,
        todayNote: "집에 가고 싶어요",
        book: book
    )
    
    container.mainContext.insert(book)
    container.mainContext.insert(log)
    
    return DivingLogView(log: log)
        .modelContainer(container)
}
