//
//  Emotion.swift
//  DiverChallenge
//
//  Created by 이승진 on 4/21/25.
//

import Foundation

enum ModeType: String, CaseIterable, Identifiable {
    case happy
    case neutral
    case sad
    case angry
    case anxious
    
    var id: String { self.rawValue }
    
    var mood: String {
        switch self {
            
        case .happy:
            return "😊"
        case .neutral:
            return "😐"
        case .sad:
            return "😢"
        case .angry:
            return "😡"
        case .anxious:
            return "😰"
        }
    }
}
