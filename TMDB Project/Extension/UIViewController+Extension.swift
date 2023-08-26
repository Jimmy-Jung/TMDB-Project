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
    
    enum TransitionStyle {
        /// 네비게이션 없이 present
        case present
        /// 네비게이션 없이 present Full
        case presentFull
        /// 네비게이션 임베드 된 present
        case presentNavigation
        /// 네비게이션 임베드 된 fullscreen present
        case presentFullNavigation
        /// 네비게이션 push
        case pushNavigation
    }
    
    /// Storyboard Transition
    /// - Parameters:
    ///   - storyboard: Storyboard's name
    ///   - viewController: ViewController's Meta Type
    ///   - style: Transition Style
    func transition<T: UIViewController>(storyboard: String, viewController: T.Type, style: TransitionStyle, preprocessViewController: ((_ vc: T) -> ())? = nil) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: viewController.identifier) as? T else {
            fatalError("There is a problem with making an instantiateViewController. The identifier may be incorrect.")
        }
        transition(viewController: vc, style: style, preprocessViewController: preprocessViewController)
    }
    
    /// ViewController Transition
    /// - Parameters:
    ///   - vc: ViewController Instance
    ///   - style: Transition Style
    func transition<T: UIViewController>(viewController vc: T, style: TransitionStyle, preprocessViewController: ((_ vc: T) -> ())? = nil) {
        preprocessViewController?(vc)
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentFull:
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .pushNavigation:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
