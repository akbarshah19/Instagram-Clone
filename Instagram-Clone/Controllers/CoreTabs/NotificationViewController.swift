//
//  NotificationViewController.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 4/29/23.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NotificationFollowTableViewCell.self, forCellReuseIdentifier: NotificationFollowTableViewCell.identifier)
        table.register(NotificationLikeTableViewCell.self, forCellReuseIdentifier: NotificationLikeTableViewCell.identifier)
        table.isHidden = false
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var noNotificationsView = UIView()
    
    private var models = [UserNotification]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
//        spinner.startAnimating()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        addNoNotificationsView()
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func fetchNotifications() {
        for x in 0...20 {
            let user = User(username: "joe_smoth",
                            bio: "",
                            name: (first: "", last: ""),
                            profilePhoto: URL(string: "https://www.google.com")!,
                            birthDate: Date(),
                            gender: .male,
                            counts: UserCount(followers: 1, following: 1, posts: 1),
                            joinDate: Date())
            
            let post = UserPost(id: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://www.google.com")!,
                                postURL: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likeCounts: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [],
                                owner: user)
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hello World",
                                         user: user)
            models.append(model)
        }
    }
    
    private func addNoNotificationsView() {
        noNotificationsView.isHidden = true
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationsView.center = view.center
        view.addSubview(noNotificationsView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(post: _):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeTableViewCell.identifier,
                                                     for: indexPath) as! NotificationLikeTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowTableViewCell.identifier,
                                                     for: indexPath) as! NotificationFollowTableViewCell
            cell.delegate = self
//            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension NotificationViewController: NotificationLikeTableViewCellDelegate {
    func didTapPost(model: UserNotification) {
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Should never get called.")
        }
    }
}

extension NotificationViewController: NotificationFollowTableViewCellDelegate {
    func didTapFolloUnfollow(model: UserNotification) {
        print("Follow tapped")
    }
}
