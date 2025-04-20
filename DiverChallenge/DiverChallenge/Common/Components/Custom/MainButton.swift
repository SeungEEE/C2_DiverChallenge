//
//  MainButton.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI

struct MainButton: View {
    let buttonType: ButtonType
    let action: () -> Void
    
    init(buttonType: ButtonType, action: @escaping () -> Void) {
        self.buttonType = buttonType
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(buttonType.text)
                .font(.pretendard(type: .medium, size: 20))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, minHeight: 59)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(buttonType.background)
                }
        })
    }
    
    enum ButtonType {
        case createOn
        case createOff
        case save
        
        var text: String {
            switch self {
            case .createOn, .createOff:
                return "생성하기"
            case .save:
                return "저장하기"
            }
        }
        
        var background: Color {
            switch self {
            case .createOn:
                return .main
            case .createOff:
                return .gray01
            case .save:
                return .main
            }
        }
    }
}

#Preview {
    MainButton(buttonType: .createOn, action: { print("메인 버튼")})
}
