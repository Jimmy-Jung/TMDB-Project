//
//  ReusableViewProtocol.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String {get}
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String { return String(describing: self) }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String { return String(describing: self) }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String { return String(describing: self) }
}
