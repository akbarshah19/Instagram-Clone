//
//  NotificationFollowTableViewCell.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/7/23.
//

import UIKit

protocol NotificationFollowTableViewCellDelegate: AnyObject {
    func didTapFolloUnfollow(model: UserNotification)
}

class NotificationFollowTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowTableViewCell"
    public weak var delegate: NotificationFollowTableViewCellDelegate?
    private var model: UserNotification?
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .tertiarySystemBackground
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@eminem started following you."
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = translatesAutoresizingMaskIntoConstraints
        contentView.addSubview(profileImage)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
        configureForFollowing()
        selectionStyle = .none
    }
    
    @objc func didTapFollow() {
        guard let model = model else {
            return
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            break
        case .follow(let state):
            switch state {
            case .following:
                configureForFollowing()
            case .not_following:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.backgroundColor = .link
            }
            break
        }
        
        label.text = model.text
        profileImage.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.frame = CGRect(x: 10, y: 6, width: contentView.height - 12, height: contentView.height - 12)
        profileImage.layer.cornerRadius = profileImage.height/2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 30
        followButton.frame = CGRect(x: contentView.width - size - 5, y: (contentView.height - buttonHeight)/2, width: size, height: buttonHeight)
        label.frame = CGRect(x: profileImage.right + 5, y: 0, width: contentView.width - size - profileImage.width - 16, height: contentView.height)
    }
    
    private func configureForFollowing() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        followButton.backgroundColor = .darkGray
    }
}
