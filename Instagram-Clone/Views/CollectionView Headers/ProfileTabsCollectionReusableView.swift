//
//  ProfileTabsCollectionReusableView.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/4/23.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridTabButton(_ view: ProfileTabsCollectionReusableView)
    func didTapTaggedTabButton(_ view: ProfileTabsCollectionReusableView)
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButon: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "person.crop.square"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        addSubview(gridButton)
        addSubview(taggedButon)
        
        gridButton.addTarget(self, action: #selector(didTapGrid), for: .touchUpInside)
        taggedButon.addTarget(self, action: #selector(didTapTagged), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - Constants.padding*2
        let gridX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridX, y: Constants.padding, width: size, height: size)
        taggedButon.frame = CGRect(x: gridX + width/2, y: Constants.padding, width: size, height: size)
    }
    
    @objc func didTapGrid() {
        gridButton.tintColor = .systemBlue
        taggedButon.tintColor = .lightGray
        delegate?.didTapGridTabButton(self)
    }
    
    @objc func didTapTagged() {
        gridButton.tintColor = .lightGray
        taggedButon.tintColor = .systemBlue
        delegate?.didTapTaggedTabButton(self)
    }
}
