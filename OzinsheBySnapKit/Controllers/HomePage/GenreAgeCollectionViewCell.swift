//
//  GenreAgeCollectionViewCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 22.02.2024.
//

import UIKit

class GenreAgeCollectionViewCell: UICollectionViewCell {
    
    var imageview: UIImageView = {
       var imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 8.0
        return imageview
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        title.textColor = .white
        title.textAlignment = .center
        
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(imageview)
        contentView.addSubview(titleLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension GenreAgeCollectionViewCell {
    func setupConstraints(){
        imageview.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(112)
            make.width.equalTo(184)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageview)
            make.horizontalEdges.equalTo(imageview).inset(16)
        }
    }
}
