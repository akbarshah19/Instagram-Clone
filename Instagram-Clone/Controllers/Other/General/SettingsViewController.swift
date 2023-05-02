//
//  SettingsViewController.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 4/29/23.
//

import UIKit

struct SettingsCellModel {
    let title: String
    let handler: () -> Void
}

final class SettingsViewController: UIViewController {
    
    var data = [[SettingsCellModel]]()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        let section = [
            SettingsCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ]
        data.append(section)
    }
    
    @objc func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Are you sure you want to log out?", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut { success in
                DispatchQueue.main.async {
                    if success {
                        //Show login screen
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true) {
                            self.navigationController?.popViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        fatalError("Could not log out user.")
                    }
                }
            }
        }))
//        actionSheet.popoverPresentationController?.sourceView = tableView
//        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds

        present(actionSheet, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}

