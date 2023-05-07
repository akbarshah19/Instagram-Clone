//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/4/23.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func didTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func didTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func didTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func didTapEditButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.layer.masksToBounds = true
        
        return image
    }()
    
    private let postsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joe Smith"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the bio."
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubviews()
        addButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profileImageSize = width/4
        profileImage.frame = CGRect(x: 5, y: 5, width: profileImageSize, height: profileImageSize).integral
        profileImage.layer.cornerRadius = profileImageSize/2
        let buttonHeight = profileImageSize/2
        let countButtonWidth = (width - 10 - profileImageSize)/3
        postsBtn.frame = CGRect(x: profileImage.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followersBtn.frame = CGRect(x: postsBtn.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followingBtn.frame = CGRect(x: followersBtn.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        editProfileBtn.frame = CGRect(x: profileImage.right, y: 5 + buttonHeight, width: countButtonWidth*3, height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5, y: 5 + profileImage.bottom, width: width - 10, height: 50)
        let bioSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width - 10, height: bioSize.height)
    }

    private func addSubviews() {
        addSubview(profileImage)
        addSubview(postsBtn)
        addSubview(followersBtn)
        addSubview(followingBtn)
        addSubview(editProfileBtn)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addButtonActions() {
        postsBtn.addTarget(self, action: #selector(didTapPosts), for: .touchUpInside)
        followersBtn.addTarget(self, action: #selector(didTapFollowers), for: .touchUpInside)
        followingBtn.addTarget(self, action: #selector(didTapFollowing), for: .touchUpInside)
        editProfileBtn.addTarget(self, action: #selector(didTapEditProfile), for: .touchUpInside)
    }
    
    @objc func didTapPosts() {
        delegate?.didTapPostsButton(self)
    }
    
    @objc func didTapFollowers() {
        delegate?.didTapFollowersButton(self)
    }
    
    @objc func didTapFollowing() {
        delegate?.didTapFollowingButton(self)
    }
    
    @objc func didTapEditProfile() {
        delegate?.didTapEditButton(self)
    }
}
