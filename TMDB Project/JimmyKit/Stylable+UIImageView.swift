//
//  Stylable+UIImageView.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/29.
//
import JimmyKit
import UIKit.UIImageView

extension Stylable where Self: UIImageView {
    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
}
