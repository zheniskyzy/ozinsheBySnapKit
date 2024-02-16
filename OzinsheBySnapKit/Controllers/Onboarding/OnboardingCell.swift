//
//  OnboardingCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 12.02.2024.
//

import UIKit
import SnapKit
import Localize_Swift

class OnboardingCell: UICollectionViewCell {
    

    var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        title.textColor = UIColor(named: "111827-White(view, font etc)")
        title.textAlignment = .center
        
        return title
    }()
    var subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        subtitle.textColor = UIColor(named: "6B7280-9CA3AF subtitle grey")
        subtitle.textAlignment = .center
        subtitle.numberOfLines = 0
        return subtitle
    }()
    

    override init(frame: CGRect) {
            super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
            setupConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setupConstraints() {
       imageView.snp.makeConstraints { make in
           make.top.equalToSuperview()
           make.horizontalEdges.equalToSuperview()
           make.height.equalTo(504)
       }
       titleLabel.snp.makeConstraints { make in
           make.horizontalEdges.equalToSuperview().inset(40)
           make.bottom.equalTo(imageView.snp.bottom).inset(2)
       }
       subtitleLabel.snp.makeConstraints { make in
           make.horizontalEdges.equalToSuperview().inset(32)
           make.top.equalTo(titleLabel.snp.bottom).inset(-24)
           
       }
    }

    
    func setData(image: UIImage, title: String, subtitle: String){
        imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
