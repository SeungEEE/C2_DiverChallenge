//
//  SplashView.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.main
            
            Image(.splash)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 280, height: 280)
        }
        .ignoresSafeArea()
    
    }
}

#Preview {
    SplashView()
}
