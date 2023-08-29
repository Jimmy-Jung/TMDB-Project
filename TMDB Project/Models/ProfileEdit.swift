//
//  ProfileEdit.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/30.
//

import Foundation

enum ProfileEdit: CaseIterable {
    case name
    case userName
    case genderPronouns
    case introduce
    case link
    case gender
    case switchToProAccount
    case personalInfoSet
    
    enum CellType {
        case none
        case disclosure
        case button
    }
    
    func getCellTitle() -> (String, String) {
        switch self {
            
        case .name:
            return ("이름", "이름")
        case .userName:
            return ("사용자 이름", "사용자 이름")
        case .genderPronouns:
            return ("성별 대명사", "성별 대명사")
        case .introduce:
            return ("소개", "소개 추가")
        case .link:
            return ("링크", "링크 추가")
        case .gender:
            return ("성별", "성별")
        case .switchToProAccount:
            return ("프로패셔널 계정으로 전환", "")
        case .personalInfoSet:
            return ("개인정보 설정", "")
        }
    }
    
    func getCellType() -> CellType {
        switch self {
            
        case .name:
            return .none
        case .userName:
            return .none
        case .genderPronouns:
            return .none
        case .introduce:
            return .none
        case .link:
            return .disclosure
        case .gender:
            return .disclosure
        case .switchToProAccount:
            return .button
        case .personalInfoSet:
            return .button
        }
    }
}
