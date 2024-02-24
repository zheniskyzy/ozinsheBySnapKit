//
//  HistoryCollectionViewCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 21.02.2024.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
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
        title.textColor = UIColor(named: "111827-White(view, font etc)")
        title.textAlignment = .left
        
        return title
    }()
    
    var subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        subtitle.textColor = UIColor(named: "9CA3AF")
        subtitle.textAlignment = .left
        subtitle.numberOfLines = 0
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(imageview)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HistoryCollectionViewCell {
    
    func setupConstraints(){
        imageview.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(112)
            make.width.equalTo(184)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageview.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-4)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
