//
//  NotificationLikeTableViewCell.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/7/23.
//

import UIKit
import SDWebImage

protocol NotificationLikeTableViewCellDelegate: AnyObject {
    func didTapPost(model: UserNotification)
}

class NotificationLikeTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeTableViewCell"
    public weak var delegate: NotificationLikeTableViewCellDelegate?
    
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
        label.text = "@joe liked your image"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "logo"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(profileImage)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc func didTapPost() {
        guard let model = model else {
            return
        }
        
        delegate?.didTapPost(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal)
        case .follow:
            break
        }
        
        label.text = model.text
        profileImage.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.frame = CGRect(x: 10, y: 6, width: contentView.height - 12, height: contentView.height - 12)
        profileImage.layer.cornerRadius = profileImage.height/2
        
        let size = contentView.height - 6
        postButton.frame = CGRect(x: contentView.width - size - 5, y: 3, width: size, height: size)
        label.frame = CGRect(x: profileImage.right + 5, y: 0, width: contentView.width - size - profileImage.width - 16, height: contentView.height)
    }
}
