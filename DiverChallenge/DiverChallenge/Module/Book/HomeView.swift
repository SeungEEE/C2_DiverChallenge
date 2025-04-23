//
//  HomeView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    /// SwiftData 컨텍스트
    @Environment(\.modelContext) private var context
    
    /// SwiftData DivingBook 생성일 순으로 불러오기
    @Query(sort: \DivingBook.createdAt) private var books: [DivingBook]
    
    /// 온보딩 이후 보여주기 위한 변수
    @AppStorage("isFirstDive") private var isFirstDive = false
    
    /// 도감 생성 버튼 누를시 전달해줄 값
    @State private var isPresented = false
    
    /// 온보딩뷰를 위한 상태 변수
    @State private var onboardingStep: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.white01.ignoresSafeArea()
                
                VStack {
                    
                    // 도감이 없다면
                    if books.isEmpty {
                        // 온보딩 처음 화면이라면
                        if onboardingStep == 0 {
                            firstOnboardingView
                                .onTapGesture {
                                    withAnimation {
                                        onboardingStep = 1
                                    }
                                }
                        } else {
                            // 위에 버튼 클릭 메시지뷰
                            emptyGridGuideView
                        }
                    } else {
                        // 도감 그리드 뷰
                        DivingGridView(books: books)
                    }
                }
                .padding(.vertical, 50)
                
                headerView
                    .safeAreaPadding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        }
        
        // 도감 생성 화면 띄우기
        .fullScreenCover(isPresented: $isPresented) {
            CreateDivingView()
        }
    }
    
    /// 다이빙 도감 Title + 도감 생성 Button
    private var headerView: some View {
        HStack {
            Text("다이빙 도감")
                .font(.pretendard(type: .bold, size: 30))
                .foregroundStyle(.black)
            
            Spacer()
            Button {
                isPresented = true
            } label: {
                Image(systemName: "widget.small.badge.plus")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 32, height: 32)
            }
        }
    }
    
    /// 처음 온보딩 메시지
    private var firstOnboardingView: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Text("다이버 도감을\n수집하러\n가볼까요??")
                    .font(.pretendard(type: .bold, size: 20))
                    .foregroundStyle(.navy01)
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
            
            Text("화면을 터치해주세요!")
                .font(.pretendard(type: .semibold, size: 18))
                .foregroundStyle(.navy01)
                .offset(y: -30)
        }
        .padding()
    }
    
    /// 도감 없을 때 보여주는 메시지
    private var emptyGridGuideView: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                Text("위의 + 버튼을\n눌러주세요!")
                    .font(.pretendard(type: .bold, size: 20))
                    .foregroundStyle(.navy01)
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
        .padding()
    }
}

#Preview {
    HomeView()
}
