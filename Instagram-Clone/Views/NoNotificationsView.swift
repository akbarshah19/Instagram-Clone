//
//  NoNotificationsView.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/6/23.
//

import UIKit

class NoNotificationsView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.text = "No Notifications"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .secondaryLabel
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "bell")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width - 50)/2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height - 50).integral
    }
}
