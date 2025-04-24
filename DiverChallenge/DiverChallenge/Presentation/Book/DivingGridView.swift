//
//  DivingGridView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI

struct DivingGridView: View {
    
    /// 도감 리스트
    var books: [DivingBook]
    
    /// SwiftData 컨텍스트
    @Environment(\.modelContext) private var context
    
    /// 2열 그리드 -> 20: 열간격
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(Array(books.enumerated()), id: \.element.id) { (index, book) in
                    NavigationLink {
                        // 카드 터치시 이동
                        DivingListView(book: book)
                    } label: {
                        // 커스텀 카드 뷰
                        DivingCardView(book: book, index: index)
                            .contextMenu {
                                Button(role: .destructive) {
                                    deleteBook(book)
                                } label: {
                                    Label("도감 삭제", systemImage: "trash")
                                }
                            }
                            .onLongPressGesture {
                                deleteBook(book)
                            }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
        }
    }
    
    /// 도감을 삭제하기 위한 함수
    private func deleteBook(_ book: DivingBook) {
        if let target = books.first(where: { $0.id == book.id }) {
            context.delete(target)
            try? context.save()
        }
    }
}

#Preview {
    let book1 = DivingBook(title: "도감1", goal: "3끼 챙겨먹기", startDate: Date(), endDate: Date().addingTimeInterval(86400 * 5))
    let book2 = DivingBook(title: "도감2", goal: "운동하기", startDate: Date(), endDate: Date().addingTimeInterval(86400 * 10))
    return NavigationStack {
        DivingGridView(books: [book1, book2])
            .modelContainer(for: [DivingBook.self, DivingDailyLog.self], inMemory: true)
    }
}
