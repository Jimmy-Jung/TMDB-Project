//
//  UIViewController+Extension.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/13.
//

import UIKit

extension UIViewController {
    func configBackBarButton(title: String?) {
        let backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .label
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}
