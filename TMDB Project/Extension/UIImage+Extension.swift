//
//  UIImage+Extension.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/14.
//

import UIKit

extension UIImage {
    static var noProfileImage: UIImage? {
        return UIImage(systemName: "person")
    }
    
    static var noPosterImage: UIImage? {
        return UIImage(named: "noPoster")
    }
}
