//
//  MovieCollectionViewCell.swift
//  Photogram
//
//  Created by 정준영 on 2023/08/28.
//

import UIKit
import JimmyKit

final class MovieCollectionCell: BaseCollectionViewCell {
    private lazy var backView: UIView = {
        let view = UIView()
            .backgroundColor(.systemBackground)
            .addSubView(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
    }()

    private lazy var mainStackView = UIStackView(arrangedSubviews: [imageView, bottomView])
        .alignment(.fill)
        .distribution(.fill)
        .axis(.vertical)
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
            .contentMode(.scaleAspectFill)
            .addSubView(rateStackView)
            .addSubView(clipButton)
        
        rateStackView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(15)
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
        clipButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.height.equalTo(50)
        }
        return iv
    }()
    
    lazy var clipButton: UIButton = {
        let config = UIImage.SymbolConfiguration(paletteColors: [.label, .secondaryLabel, .systemBackground])
            .applying(UIImage.SymbolConfiguration(pointSize: 20))
            
        
        return ButtonBuilder(.filled)
            .image(UIImage(systemName: "paperclip.circle.fill", withConfiguration: config))
            .baseBackgroundColor(.clear)
            .makeButton()
            
    }()
   
    private lazy var rateStackView = UIStackView(arrangedSubviews: [rateTextLabel, rateLabel])
        .axis(.horizontal)
        .alignment(.fill)
        .distribution(.fillEqually)
    
    private lazy var rateTextLabel = UILabel()
        .text("평점")
        .textAlignment(.center)
        .font(.systemFont(ofSize: 14))
        .textColor(.white)
        .backgroundColor(.systemIndigo)
    
    private lazy var rateLabel = UILabel()
        .text("0.0")
        .textAlignment(.center)
        .font(.systemFont(ofSize: 14))
        .backgroundColor(.systemBackground)
    
    private lazy var bottomView: UIView = {
        let view = UIView()
            .backgroundColor(.systemBackground)
            .addSubView(bottomStackView)
        bottomStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
        }
        titleStackView.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        detailStackView.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        detailImageView.setContentHuggingPriority(.init(251), for: .horizontal)
        detailImageView.tintColor = .label
        return view
    }()
    
    private lazy var bottomStackView = UIStackView(arrangedSubviews: [titleStackView, separatorView, detailStackView])
        .axis(.vertical)
        .alignment(.fill)
        .distribution(.fill)
        .spacing(12)
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [titleLabel, originalTitleLabel])
        .axis(.horizontal)
        .alignment(.fill)
    
    private let titleLabel = UILabel()
        .font(.systemFont(ofSize: 17, weight: .semibold))
    
    private let originalTitleLabel = UILabel()
        .font(.systemFont(ofSize: 17, weight: .semibold))
    
    private let separatorView = UIView()
        .backgroundColor(.label)
    
    private lazy var detailStackView = UIStackView(arrangedSubviews: [detailLabel, detailImageView])
        .axis(.horizontal)
        .alignment(.fill)
    
    private let detailLabel = UILabel()
        .text("자세히 보기")
        .font(.systemFont(ofSize: 12, weight: .medium))
    
    private let detailImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    override func configurationView() {
        contentView.addSubview(backView)
        backView.layer.cornerRadius = 20
        backView.layer.masksToBounds = true
        makeShadow()
    }
    override func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    var movieInfo: MovieInfo? {
        didSet {
            titleLabel.text = movieInfo?.title
            originalTitleLabel.text = movieInfo?.originalTitle
            rateLabel.text = String(format: "%.1f", movieInfo?.voteAverage ?? 0)
            guard let path = movieInfo?.posterPath else {
                imageView.image = UIImage.noPosterImage
                return
            }
            let url = TMDB_API.imageURL(
                width: 300,
                path: path
            )
            self.imageView.kf.setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage.noPosterImage
    }
    
    func hideViews() {
        rateStackView.isHidden = true
        bottomView.isHidden = true
    }
    
    private func makeShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    // 다크모드 전환시 그림자 색상 변경
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13, *), self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.shadowColor = UIColor.label.cgColor
            }
    }
}
