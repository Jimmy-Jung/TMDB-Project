//
//  RecommendViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/17.
//

import UIKit

final class RecommendViewController: UIViewController {

    @IBOutlet weak var recommendTableView: UITableView!
    private var movieList: [MovieInfo] = []
    private var recommendList: [[MovieInfo]] = []
    private let networkManager = TMDBNetworkManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureTableViewLayout()
        callTrending()
    }
    private func callTrending() {
        networkManager.requestTMDB(
            requestOption: .trendings(.week),
            metaType: Trendings.self
        ) { [weak self] trendings in
            guard let list = trendings.results else { return }
            self?.movieList = list
            self?.callRecommendationWithDispatchGroup()
        }
    }
    
    private func callRecommendationWithDispatchGroup() {
        movieList.forEach {
            networkManager.requestTMDB(
                requestOption: .recommendation($0.id ?? 1),
                metaType: Recommendations.self
            ) { [weak self] data in
                if data.results.count > 1 {
                    self?.recommendList.append(data.results)
                    self?.recommendTableView.reloadData()
                }
            }
        }
    }

}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.recommendList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.identifier, for: indexPath) as! RecommendTableViewCell
        cell.movieInfo = recommendList[indexPath.section]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = movieList[section].title else { return "관련 영화" }
        return "[\(title)]의 추천 영화"
    }
    
}
extension RecommendViewController: TableViewAttributeProtocol {
    func configureTableView() {
        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        let nib = UINib(nibName: RecommendTableViewCell.identifier, bundle: nil)
        recommendTableView.register(nib, forCellReuseIdentifier: RecommendTableViewCell.identifier)
    }
    
    func configureTableViewLayout() {
        let inset: CGFloat = 20
        let width = (UIScreen.main.bounds.width - (inset * 4)) / 2
        recommendTableView.rowHeight = width * (4/3) + (inset * 2)
    }
    
}
protocol Pushable {
    func pushNavigation(movieInfo: MovieInfo)
}
extension RecommendViewController: Pushable {
    func pushNavigation(movieInfo: MovieInfo) {
        transition(storyboard: "Main", viewController: CreditViewController.self, style: .pushNavigation) { vc in
            vc.movieInfo = movieInfo
        }
    }
    
    
}
