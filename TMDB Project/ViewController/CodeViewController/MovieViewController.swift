//
//  MovieViewController1.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/28.
//

import UIKit

final class MovieViewController: BaseViewController {
    private let titleText = "TMDB"
    private lazy var movieCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: configCollectionView())
        return cv
    }()
    
    private var movieList: [MovieInfo] = []
    private let networkManager = TMDBNetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleText
        setupBarButtonItem()
        callRequest()
    }
    

    @objc func rightBarButtonTapped() {
        transition(viewController: ProfileViewController(), style: .presentFullNavigation) { vc in
            vc.title = "프로필 편집"
        }
    }
    
    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: SystemImage.makeImage(.personCircleFill), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    private func callRequest() {
        networkManager.requestTMDB(
            requestOption: .trendings(.week),
            metaType: Trendings.self
        ) { [weak self] trendings in
            guard let list = trendings.results else { return }
            self?.movieList.append(contentsOf: list)
            self?.movieCollectionView.reloadData()
        }
    }
    
    override func configurationView() {
        view.addSubview(movieCollectionView)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.identifier)
        movieCollectionView.register(MovieCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieCollectionReusableView.identifier)
    }
    override func setConstraints() {
        movieCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configCollectionView() -> UICollectionViewFlowLayout {
        let layout = UICollectionView.getCollectionViewFlowLayout(
            numberOfRows: 1,
            itemRatio: 4/3,
            spacing: 40,
            inset: 40,
            scrollDirection: .vertical
        )
        return layout
    }
}
extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.identifier, for: indexPath) as! MovieCollectionCell
        cell.movieInfo = movieList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: CreditViewController.identifier) as! CreditViewController
        vc.movieInfo = movieList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieCollectionReusableView.identifier, for: indexPath) as! MovieCollectionReusableView
        headerView.titleLabel.font = .systemFont(ofSize: 25, weight: .black)
        headerView.titleLabel.text = "#Week Trending"
        return headerView
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int)
    -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
}
