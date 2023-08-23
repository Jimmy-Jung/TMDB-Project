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
    
    func showCancelAlert(
            title: String?,
            message: String?,
            preferredStyle: UIAlertController.Style,
            cancelTitle: String?,
            okTitle: String?,
            cancelHandler: ((UIAlertAction) -> Void)? = nil,
            okHandler: ((UIAlertAction) -> Void)? = nil
        ) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler)
            let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
}
