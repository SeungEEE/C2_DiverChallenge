//
//  DivingCardView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI

struct DivingCardView: View {
    let book: DivingBook
    let index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 바
            HStack {
                Text("No. \(index + 1)")
                Spacer()
                Text(book.title)
            }
            .foregroundColor(.white)
            .font(.pretendard(type: .semibold, size: 12))
            .padding(.horizontal)
            .frame(height: 40)
            .background(.main)
            .roundingCorner(20, corners: [.topLeft, .topRight])
            
            // 중앙 이미지
            Image("book\(index % 5 + 1)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: 120)
                .background(Color.white)
            
            // 하단 바
            Text(book.goal)
                .font(.pretendard(type: .semibold, size: 12))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(.main)
                .roundingCorner(20, corners: [.bottomLeft, .bottomRight])
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
        )
        .frame(width: 140)
    }
}

#Preview {
    let sampleBook = DivingBook(
        title: "디자인 챌린지",
        goal: "매일 UI 개선하기",
        startDate: Date(),
        endDate: Date().addingTimeInterval(86400 * 5)
    )
    return DivingCardView(book: sampleBook, index: 0)
}
