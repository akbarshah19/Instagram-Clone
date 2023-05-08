//
//  FeedPostActionsTableViewCell.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/3/23.
//

import UIKit

class FeedPostActionsTableViewCell: UITableViewCell {
    static let identifier = "FeedPostActionsTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
