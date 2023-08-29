//
//  ProfileTableViewCell.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/29.
//

import UIKit

final class ProfileTableViewCell: BaseTableViewCell {
    private lazy var stackView = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
    lazy var leftLabel = UILabel()
        .textColor(.label)
        .font(.boldSystemFont(ofSize: 14))
    lazy var rightLabel = UILabel()
        .textColor(.placeholderText)
        .font(.boldSystemFont(ofSize: 14))
    
    override func configurationView() {
        contentView.addSubview(stackView)
    }
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        leftLabel.snp.makeConstraints { make in
            make.width.equalTo(90)
        }
    }
}
