//
//  ImageName.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/26.
//

import UIKit

enum ImageName: String, CaseIterable {
    case first
    case second
    case third
    case fourth
    case fifth
    
    static func getImageList() -> [UIImage] {
        var list: [UIImage] = []
        self.allCases.forEach {
            guard let image = UIImage(named: $0.rawValue) else { return }
            list.append(image)
        }
        return list
    }
}
