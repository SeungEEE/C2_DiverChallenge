//
//  HideKeyboard.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/22/25.
//

import SwiftUI

/// 화면 터치시 키보드 내림
extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil
            )
        }
    }
}
