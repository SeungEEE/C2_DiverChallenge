//
//  DivingGridView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI

struct DivingGridView: View {
    var books: [DivingBook]
    @Environment(\.modelContext) private var context
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 24) {
                ForEach(Array(books.enumerated()), id: \.element.id) { (index, book) in
                    NavigationLink {
                        DivingListView(book: book)
                    } label: {
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
        context.delete(book)
        try? context.save()
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
