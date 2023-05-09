//
//  FeedPostHeaderTableViewCell.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/3/23.
//

import UIKit

protocol FeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class FeedPostHeaderTableViewCell: UITableViewCell {
    static let identifier = "FeedPostHeaderTableViewCell"
    public weak var delegate: FeedPostHeaderTableViewCellDelegate?
    
    private let profilePhoto: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePhoto)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapMore() {
        
    }
    
    public func configure(with model: User) {
        usernameLabel.text = model.username
        profilePhoto.image = UIImage(systemName: "person.circle")
//        profilePhoto.sd_setImage(with: model.profilePhoto)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        profilePhoto.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profilePhoto.layer.cornerRadius = profilePhoto.height/2
        moreButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        usernameLabel.frame = CGRect(x: profilePhoto.right + 10, y: 2, width: contentView.width - size*2 - 15, height: contentView.height - 4)
    }
}
