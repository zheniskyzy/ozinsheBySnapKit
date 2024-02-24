//
//  ScreenshotCollectionViewCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 23.02.2024.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    var imageview: UIImageView = {
       var imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 8
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageview)
        imageview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
