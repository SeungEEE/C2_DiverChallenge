//
//  RoundedCorner.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import SwiftUI

/// 부분 코너를 주기 위한 구조체
struct RoundedCorner : Shape {
    var radius : CGFloat
    var corners : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundingCorner(_ radius : CGFloat, corners : UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
