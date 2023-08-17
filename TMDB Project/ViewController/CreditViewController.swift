//
//  CreditViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/13.
//

import UIKit
import Kingfisher
import SnapKit

final class CreditViewController: UIViewController {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backPosterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var creditTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    private let networkManager = TMDBNetworkManager.shared
    private var castList: [Cast] = []
    private var crewList: [Cast] = []
    private var buttonToggle: Bool = false
    var movieInfo: MovieInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "출연/제작 "
        setupTableView()
        callRequest()
        fetchLabels()
        fetchImageViews()
        descriptionLabel.sizeToFit()
        headerView.sizeToFit()
        headerView.setNeedsLayout()
        headerView.setNeedsDisplay()
    }
    
    private func setupTableView() {
        creditTableView.delegate = self
        creditTableView.dataSource = self
    }
    private func fetchLabels() {
        movieTitleLabel.text = movieInfo?.title
        descriptionLabel.text = movieInfo?.overview
    }
    private func fetchImageViews() {
        let retryStrategy = DelayRetryStrategy(maxRetryCount: 2, retryInterval: .seconds(3))
        let posterUrl = TMDB_API.imageURL(
            width: 200,
            path: movieInfo?.posterPath ?? ""
        )
        posterImageView.kf.setImage(
            with: posterUrl,
            placeholder: UIImage.noPosterImage,
            options: [
                .retryStrategy(retryStrategy),
                .transition(.fade(0.5))
            ])
        let backdropUrl = TMDB_API.imageURL(
            width: 500,
            path: movieInfo?.backdropPath ?? ""
        )
        backPosterImageView.kf.setImage(
            with: backdropUrl,
            placeholder: UIImage.noPosterImage,
            options: [
                .retryStrategy(retryStrategy),
                .transition(.fade(0.5))
            ])
    }
    
    private func callRequest() {
        networkManager.requestCredits(movieID: movieInfo?.id ?? 0) { [weak self] credits in
            guard let self else { return }
            castList = credits.cast ?? []
            crewList = credits.crew ?? []
            creditTableView.reloadData()
        }
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
//        creditTableView.beginUpdates()
        if !buttonToggle {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.sizeToFit()
            headerView.frame.size.height += descriptionLabel.frame.size.height - 53
            sender.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            descriptionLabel.numberOfLines = 2
            headerView.frame.size.height = 153
            sender.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
//        creditTableView.endUpdates()
        creditTableView.sectionHeaderTopPadding = buttonToggle ? 0.02 : 0.01
        
        
        buttonToggle.toggle()
    }
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return castList.count
        } else {
            return crewList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier, for: indexPath) as! CreditTableViewCell
        if indexPath.section == 0 {
            cell.cast = castList[indexPath.row]
        } else {
            cell.crew = crewList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView()
        backView.backgroundColor = .systemBackground
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = section == 0 ? "Cast" : "Crew"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        
        backView.addSubview(label)
        label.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        return backView
    }
}
