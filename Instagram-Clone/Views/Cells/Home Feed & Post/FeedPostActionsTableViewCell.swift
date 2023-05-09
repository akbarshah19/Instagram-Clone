//
//  FeedPostActionsTableViewCell.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/3/23.
//

import UIKit

protocol FeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLike()
    func didTapComment()
    func didTapShare()
}

class FeedPostActionsTableViewCell: UITableViewCell {
    static let identifier = "FeedPostActionsTableViewCell"
    
    public weak var delegate: FeedPostActionsTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold)), for: .normal)
        btn.tintColor = .label
        return btn
    }()
    
    private let commentButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "message", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold)), for: .normal)
        btn.tintColor = .label
        return btn
    }()
    
    private let shareButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold)), for: .normal)
        btn.tintColor = .label
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
    
    @objc func didTapLikeButton() {
        delegate?.didTapLike()
    }
    
    @objc func didTapCommentButton() {
        delegate?.didTapComment()
    }
    
    @objc func didTapShareButton() {
        delegate?.didTapShare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = contentView.height - 10
        likeButton.frame = CGRect(x: 5, y: 5, width: buttonSize, height: buttonSize)
        commentButton.frame = CGRect(x: likeButton.right, y: 5, width: buttonSize, height: buttonSize)
        shareButton.frame = CGRect(x: commentButton.right, y: 5, width: buttonSize, height: buttonSize)
    }
}
