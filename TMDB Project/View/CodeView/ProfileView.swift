//
//  ProfileView.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/29.
//

import UIKit
import JimmyKit

final class ProfileView: BaseView {
    private lazy var profileHeaderView: UIView = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 130))
    private lazy var profileStackView = UIStackView(arrangedSubviews: [profileImageStackView, profileEditButton])
        .axis(.vertical)
        .alignment(.fill)
        .distribution(.fill)
        .spacing(4)
    
    private lazy var profileImageStackView = UIStackView(arrangedSubviews: [profileImageView, avatarImageView])
        .axis(.horizontal)
        .alignment(.fill)
        .distribution(.fill)
        .spacing(12)
    private lazy var profileImageView = UIImageView(image: SystemImage.makeImage(.personCircleFill))
        .contentMode(.scaleAspectFill)
        .tintColor(.secondaryLabel)
    
    private lazy var avatarImageView = UIImageView(image: SystemImage.makeImage(.squarePencilCircle))
        .contentMode(.scaleAspectFit)
        .tintColor(.secondaryLabel)
    
    private lazy var profileEditButton: UIButton = ButtonBuilder(.plain)
        .baseForegroundColor(.systemBlue)
        .titleWithFont(title: "사진 또는 아바타 수정", size: 14, weight: .bold)
        .addAction { [unowned self] in self.profileEditButtonTapped?() }
        .makeButton()
    
    lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableHeaderView = profileHeaderView
        return tableView
    }()
    
    var profileEditButtonTapped: (() -> Void)?
    
    override func configureView() {
        profileHeaderView.addSubview(profileStackView)
        self.addSubView(profileTableView)
    }
    override func setConstraints() {
        setupHeaderView()
        profileTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupHeaderView() {
      
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        profileStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
//        profileEditButton.snp.makeConstraints { make in
//            make.top.equalTo(profileImageStackView.snp.bottom).offset(12)
//            make.centerX.equalToSuperview()
//        }
    }
}
