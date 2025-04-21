//
//  HomeView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \DivingBook.createdAt) private var books: [DivingBook]
    
    /// 온보딩뷰를 위한 상태 변수
    @State private var isTapped = false
    
    /// 온보딩 이후 보여주기 위한 변수
    @AppStorage("isFirstDive") private var isFirstDive = false
    
    @State private var isPresentingCreateSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.white01.ignoresSafeArea()
                
                VStack {
                    Spacer().frame(height: 50)
                    
                    if isFirstDive {
                        DivingGridView(books: books)
                    } else {
                        onboardingView
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isTapped = true
                                    isFirstDive = true
                                }
                            }
                    }
                }
                
                headerView
                    .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
        
        .fullScreenCover(isPresented: $isPresentingCreateSheet) {
            CreateDivingView()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("다이빙 도감")
                .font(.pretendard(type: .bold, size: 30))
                .foregroundStyle(.main)
            
            Spacer()
            
            if isFirstDive || isTapped {
                Button {
                    isPresentingCreateSheet = true
                } label: {
                    Image(systemName: "plus.square.fill.on.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.main)
                        .frame(width: 40, height: 40)
                }
            }
        }
    }
    
    private var onboardingView: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Text(isTapped ? "위의 + 버튼을 \n눌러주세요!" : "다이버 도감을\n수집하러\n가볼까요??")
                    .font(.pretendard(type: .bold, size: 20))
                    .foregroundStyle(.main)
                    .multilineTextAlignment(.center)
                    .offset(x: 0, y: -20)
                
                Image(.messageIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
            }
            .offset(x: 90, y: 10)
            
            Image(.home)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.main)
                .frame(width: 220)
        }
    }
}

#Preview {
    HomeView()
}
