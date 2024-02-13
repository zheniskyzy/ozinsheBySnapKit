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
        return imageview
    }()
    
    var title: UILabel{
        let title = UILabel()
        title.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        title.textColor = UIColor(named: "111827-White(view, font etc)")
        
        return title
    }
    var subtitle: UILabel{
        let subtitle = UILabel()
        subtitle.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        subtitle.textColor = UIColor(named: "6B7280-9CA3AF subtitle grey")
        return subtitle
    }
    

    override init(frame: CGRect) {
            super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
            setupConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setupConstraints() {
       imageView.snp.makeConstraints { make in
           make.top.equalTo(contentView.safeAreaLayoutGuide)
           make.horizontalEdges.equalToSuperview()
           make.height.equalTo(504)
       }
       title.snp.makeConstraints { make in
           make.horizontalEdges.equalToSuperview().inset(40)
           make.bottom.equalTo(imageView.snp.bottom).inset(2)
       }
       subtitle.snp.makeConstraints { make in
           make.horizontalEdges.equalToSuperview().inset(24)
           make.top.equalTo(title.snp.bottom).inset(24)
           
       }
    }

    
    func setData(image: UIImage, title1: String, subtitle1: String){
        imageView.image = image
        title.text = title1
        subtitle.text = subtitle1
    }
    
    
    
    
    
}
