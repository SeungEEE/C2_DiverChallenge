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
    
    @State private var goal: String = ""
    @State private var word: String = ""
    
    @FocusState private var goalIsFocused: Bool
    @FocusState private var wordIsFocused: Bool
    
    // 선택된 아이템 종류를 저장하는 상태 변수
    @State private var newModeType: ModeType = .happy
    
    var body: some View {
        VStack(spacing: 16) {
            TopView
            
            goalView
            
            wordView
            
            moodView
            
            bottomView
        }
        .safeAreaPadding(EdgeInsets(top: 32, leading: 16, bottom: 0, trailing: 16))
        .navigationTitle("Challenge 2")
    }
    
    /// 전체 목표 + 남은 날짜를 보여주는 뷰
    private var TopView: some View {
        VStack {
            HStack {
                Label {
                    Text("디자인 야무지게 하기")
                        .font(.pretendard(type: .semibold, size: 30))
                    
                } icon: {
                    Image(systemName: "rosette")
                        .resizable()
                        .frame(width: 24, height: 30)
                }
                .foregroundStyle(.main)
                
                Spacer()
                
                Text("Day1")
                    .font(.pretendard(type: .semibold, size: 16))
                    .foregroundStyle(.main)
                    .offset(y: 10)
            }
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 3)
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
    
    /// toggleButton Action
    //    private func toggleDone(_ task: Task) {
    //        task.isDone.toggle()
    //        try? context.save()
    //    }
    
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
            Picker("아이템 종류", selection: $newModeType) {
                ForEach(ModeType.allCases, id: \.self) { type in
                    Text("\(type.mood)")
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 3)
        }
    }
    
    /// 오늘 날짜 + 저장하기 버튼
    private var bottomView: some View {
        VStack(alignment: .trailing) {
            Text("2025.04.21(월)")
                .font(.pretendard(type: .semibold, size: 16))
            
            Spacer()
            
            MainButton(buttonType: .save) {
                print("저장하기")
            }
        }
    }
}

//#Preview {
//    DivingLogView()
//}
