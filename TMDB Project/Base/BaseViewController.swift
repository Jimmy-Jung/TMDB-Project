//
//  BaseViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurationView()
        setConstraints()
    }
    
    func configurationView() {}
    func setConstraints() {}
}
