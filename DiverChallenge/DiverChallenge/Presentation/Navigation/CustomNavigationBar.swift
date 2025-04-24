//
//  CustomNavigationBar.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/23/25.
//

import SwiftUI
import UIKit

struct CustomNavigationBar: View {
    let title: String
    let showBackButton: Bool
    let rightButtonImage: Image?
    let rightButtonAction: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        title: String,
        showBackButton: Bool = true,
        rightButtonImage: Image? = nil,
        rightButtonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.showBackButton = showBackButton
        self.rightButtonImage = rightButtonImage
        self.rightButtonAction = rightButtonAction
    }
    
    var body: some View {
        HStack {
            // 왼쪽
            if showBackButton {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 12)
                }
            } else {
                Spacer().frame(width: 12)
            }
            
            Spacer()
            
            // 타이틀
            Text(title)
                .font(.pretendard(type: .semibold, size: 18))
                .foregroundColor(.black)
            
            Spacer()
            
            // 오른쪽
            if let image = rightButtonImage,
               let action = rightButtonAction {
                Button(action: action) {
                    image
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 12)
                }
                .frame(width: 12, alignment: .trailing)
            } else {
                Spacer().frame(width: 12)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

/// 뒤로가기 스와이프
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
 
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


#Preview {
    CustomNavigationBar(
        title: "가입하기",
        rightButtonImage: Image(systemName: "plus"),
        rightButtonAction: { print("오른쪽 버튼 눌림") }
    )
}
