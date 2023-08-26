//
//  DescriptionViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/26.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        delegate?.changeRootViewController()
    }
    
    var delegate: Dismissable?
 
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(closeButton)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(-20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.transition(
            with: closeButton,
            duration: 0.3,
            options: [.curveEaseIn ]
        ) {
            self.closeButton.backgroundColor = .systemBlue
            self.closeButton.setTitleColor(.white, for: .normal)
        }
    }


}
