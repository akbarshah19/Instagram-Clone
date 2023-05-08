//
//  FeedPostGeneralTableViewCell.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/3/23.
//

import UIKit

class FeedPostGeneralTableViewCell: UITableViewCell {
    static let identifier = "FeedPostGeneralTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .red
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
