//
//  FeedPostTableViewCell.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/3/23.
//

import UIKit
import AVFoundation
import SDWebImage

final class FeedPostTableViewCell: UITableViewCell {
    static let identifier = "FeedPostTableViewCell"
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = nil
        image.clipsToBounds = true
        return image
    }()
    
    private var player: AVPlayer?
    private let playerLayer = AVPlayerLayer()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImage)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        postImage.image = UIImage(named: "logo")
        return
        
        switch post.postType {
        case .photo:
            //load an image
            postImage.sd_setImage(with: post.postURL)
        case .video:
            //load a video and play
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImage.frame = contentView.bounds
    }
}
