//
//  CreateDivingView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/18/25.
//

import SwiftUI

struct CreateDivingView: View {
    @Environment(\.modelContext) private var context
        @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var goal: String = ""
    @State private var startDate = Date()
    @State private var endDate = Date()

    var body: some View {
        VStack(spacing: 72) {
            titleView
            
            goalView
            
            dateView
            
            Spacer()
            
            MainButton(buttonType: title.isEmpty || goal.isEmpty ? .createOff : .createOn) {
                createBook()
            }
        }
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
    
    /// 다이빙 제목 Text + TextField
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("다이빙 제목")
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.main)
            TextField("제목을 입력해주세요", text: $title)
                .padding()
                .background(.white) // 내부 배경 흰색
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
                .foregroundStyle(.main)
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
                .foregroundStyle(.main)
            HStack {
                Label {
                    Text("시작")
                } icon: {
                    Image(systemName: "water.waves.and.arrow.trianglehead.down")
                }
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.main)
                
                DatePicker("", selection: $startDate)
            }
            
            HStack {
                Label {
                    Text("종료")
                } icon: {
                    Image(systemName: "water.waves.and.arrow.trianglehead.up")
                }
                .font(.pretendard(type: .bold, size: 20))
                .foregroundStyle(.main)
                
                DatePicker("", selection: $endDate)
            }
        }
    }
    
    private func createBook() {
           // 유효성 검사 (제목/목표 비어있거나 날짜 역순이면 실패)
           guard !title.isEmpty, !goal.isEmpty, startDate <= endDate else {
               // TODO: 에러 메시지 출력도 가능
               return
           }

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
