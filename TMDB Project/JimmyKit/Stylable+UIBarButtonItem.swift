//
//  Stylable+ UIBarButtonItem.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/30.
//

import JimmyKit
import UIKit.UIBarButtonItem

extension Stylable where Self: UIBarButtonItem {
    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}
