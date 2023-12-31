//
//  IntroPageViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/26.
//

import UIKit

protocol Dismissable {
    func changeRootViewController()
}

final class IntroPageViewController: UIPageViewController {
    
    var introList: [UIViewController] = []

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        delegate = self
        dataSource = self
        fetchIntroList()
        setFirstViewController()
    }
    
    private func DoNotShowIntroPage() {
        UM.isLaunched = true
    }
    
    private func fetchIntroList() {
        let imageList = ImageName.getImageList()
        for (index, image) in imageList.enumerated() {
            let vc = DescriptionViewController(image: image)
            if index == imageList.endIndex - 1 {
                vc.delegate = self
                vc.closeButton.isHidden = false
            }
            introList.append(vc)
        }
    }
    
    private func setFirstViewController() {
        guard let first = introList.first else {return}
        setViewControllers([first], direction: .forward, animated: true)
    }
}

extension IntroPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = introList.firstIndex(of: viewController) else {return nil}
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : introList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = introList.firstIndex(of: viewController) else {return nil}
        let nextIndex = currentIndex + 1
        return nextIndex >= introList.count ? nil : introList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return introList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = introList.firstIndex(of: first) else { return 0}
        return index
    }
}

extension IntroPageViewController: Dismissable {
    func changeRootViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Main") as! UITabBarController
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
        DoNotShowIntroPage()
    }
}


