//
//  Font+.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/15/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretendard {
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Medium"
            case .light:
                return "Pretendard-Light"
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
