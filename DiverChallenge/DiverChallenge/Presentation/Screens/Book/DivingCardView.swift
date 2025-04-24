//
//  DivingCardView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI

struct DivingCardView: View {
    
    /// 도감 모델
    let book: DivingBook
    
    /// 도감 번호
    let index: Int
    
    var body: some View {
        VStack(spacing: 0) {

            
            // 상단 이미지
            Image("book\(book.imageIndex)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: 120)
                .background(Color.white)
                .roundingCorner(10, corners: [.topLeft, .topRight])
            
            // 상단 바
            HStack {
                Text("No. \(index + 1)")
                Spacer()
                Text(book.title)
            }
            .foregroundColor(.white)
            .font(.pretendard(type: .semibold, size: 12))
            .padding(.horizontal)
            .frame(height: 30)
            .background(.main)
            
            Divider()
            
            // 하단 바
            Text(book.goal)
                .font(.pretendard(type: .semibold, size: 10))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(.main)
                .roundingCorner(10, corners: [.bottomLeft, .bottomRight])
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 1)
        )
        .frame(width: 160)
    }
}

#Preview {
    let sampleBook = DivingBook(
        title: "예시 제목입니다",
        goal: "예시 목표입니다",
        startDate: Date(),
        endDate: Date().addingTimeInterval(86400 * 5)
    )
    return DivingCardView(book: sampleBook, index: 0)
}
