//
//  ProfileViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/29.
//

import UIKit
import JimmyKit

final class ProfileViewController: UIViewController {
    private let cellList = ProfileEdit.allCases
    private let profileView = ProfileView()
    override func loadView() {
        view = profileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBarButtonItem()
    }
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .label
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(rightBarButtonTapped))
    }
    private func setupTableView() {
        profileView.profileTableView.delegate = self
        profileView.profileTableView.dataSource = self
        profileView.profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        profileView.profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellList[indexPath.row].getCellType() == .button {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
            cell.textLabel?
                .text(cellList[indexPath.row].getCellTitle().0)
                .textColor(.systemBlue)
                .font(.boldSystemFont(ofSize: 14))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            let texts = cellList[indexPath.row].getCellTitle()
            cell.leftLabel.text(texts.0)
            cell.rightLabel.text(texts.1)
            if cellList[indexPath.row].getCellType() == .disclosure {
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = cellList[indexPath.row].getCellTitle().0
        if cellList[indexPath.row].getCellType() == .button {
            showCancelAlert(title: text, message: nil, preferredStyle: .alert, cancelTitle: "취소", okTitle: "확인")
        } else {
            let vc = TitleViewController()
            vc.textField.placeholder(text)
            vc.completionHandler = { text in
                let cell = tableView.cellForRow(at: indexPath) as! ProfileTableViewCell
                cell.rightLabel
                    .text(text)
                    .textColor(.label)
            }
            transition(viewController: vc, style: .pushNavigation)
           
        }
    }
    
    
}
