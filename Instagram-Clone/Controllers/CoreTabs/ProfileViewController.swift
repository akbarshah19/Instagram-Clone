//
//  ProfileViewController.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 4/29/23.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapSettings))
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
