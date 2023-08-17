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
    @IBOutlet weak var creditTableView: UITableView!
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
    }
    
    private func setupTableView() {
        creditTableView.delegate = self
        creditTableView.dataSource = self
        creditTableView.rowHeight = UITableView.automaticDimension
        creditTableView.sectionHeaderTopPadding = 0
    }
    private func fetchLabels() {
        movieTitleLabel.text = movieInfo?.title
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
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return castList.count
        default:
            return crewList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier, for: indexPath) as! CreditTableViewCell
        let overView = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier) as! OverViewTableViewCell
        switch indexPath.section {
        case 0:
            overView.descriptionLabel.text = movieInfo?.overview
            return overView
        case 1:
            cell.cast = castList[indexPath.row]
            return cell
        default:
            cell.crew = crewList[indexPath.row]
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView()
        backView.backgroundColor = .systemBackground
        let label = UILabel()
        label.textColor = .secondaryLabel
        
        label.font = .systemFont(ofSize: 17, weight: .bold)
        
        backView.addSubview(label)
        label.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        if section == 1 {
            label.text =  "Cast"
        } else if section == 2 {
            label.text = "Crew"
        } else {
            backView.frame.size.height = 0
        }
        return backView
    }
}
