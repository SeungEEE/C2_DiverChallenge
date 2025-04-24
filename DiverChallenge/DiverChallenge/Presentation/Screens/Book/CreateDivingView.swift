//
//  CreateDivingView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/18/25.
//

import SwiftUI
import SwiftData

struct CreateDivingView: View {
    /// SwiftData 모델 저장용
    @Environment(\.modelContext) private var context
    
    /// 화면 닫기 위한 환경 변수
    @Environment(\.dismiss) private var dismiss
    
    /// 다이빙 제목 저장 위한 변수
    @State private var title: String = ""
    
    /// 다이빙 목표 저장 위한 변수
    @State private var goal: String = ""
    
    /// 잠수 기간 시작일 저장 위한 변수
    @State private var startDate = Date()
    
    /// 잠수 기간 종료일 저장 위한 변수
    @State private var endDate = Date()

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: "도감 만들기",
                showBackButton: true
            )
            
            Divider()
            
            ScrollView {
                VStack(spacing: 72) {
                    titleView
                    
                    goalView
                    
                    dateView
                    
                    Spacer()
                    
                    // 제목, 목표 모두 입력 되어야 버튼 활성화
                    MainButton(buttonType: title.isEmpty || goal.isEmpty ? .createOff : .createOn) {
                        createBook()
                    }
                }
                .safeAreaPadding(EdgeInsets(top: 30, leading: 16, bottom: 0, trailing: 16))
            }
            .hideKeyboardOnTap()
        }
    }
    
    /// 다이빙 제목 Text + TextField
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("다이빙 제목")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.black)
            
            TextField("제목을 입력해주세요", text: $title)
                .padding()
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray01, lineWidth: 1)
                )
                .frame(height: 60)
        }
    }
    
    /// 다이빙 목표 Text + TextField
    private var goalView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("다이빙 목표")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.black)
            
            TextField("목표를 입력해주세요", text: $goal)
                .padding()
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray01, lineWidth: 1)
                )
                .frame(height: 60)
        }
    }
    
    /// 잠수 기간 설정 뷰 
    private var dateView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("잠수 기간을 선택해주세요!")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.black)
            
            HStack {
                Label {
                    Text("시작")
                        .foregroundStyle(.black)
                } icon: {
                    Image(systemName: "water.waves.and.arrow.trianglehead.down")
                        .foregroundStyle(.main)
                }
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.main)
                
                DatePicker("", selection: $startDate)
                    .datePickerStyle(.compact)
            }
            
            HStack {
                Label {
                    Text("종료")
                        .foregroundStyle(.black)
                } icon: {
                    Image(systemName: "water.waves.and.arrow.trianglehead.up")
                        .foregroundStyle(.main)
                }
                .font(.pretendard(type: .bold, size: 20))
                
                
                DatePicker("", selection: $endDate)
                    .datePickerStyle(.compact)
            }
        }
    }
    
    /// 도감 생성 함수
    private func createBook() {
        // 유효성 검사 (제목/목표 비어있거나 날짜 역순이면 실패)
        guard !title.isEmpty, !goal.isEmpty, startDate <= endDate else { return }
        
        let newBook = DivingBook(
            title: title,
            goal: goal,
            startDate: startDate,
            endDate: endDate
        )
        
        context.insert(newBook)
        try? context.save()
        dismiss()
    }
}

#Preview {
    CreateDivingView()
}
