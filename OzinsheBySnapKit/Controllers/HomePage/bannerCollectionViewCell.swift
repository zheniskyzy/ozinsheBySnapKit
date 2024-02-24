//
//  bannerCollectionViewCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 20.02.2024.
//

import UIKit
import SnapKit
import SDWebImage

class bannerCollectionViewCell: UICollectionViewCell {
    var imageview: UIImageView = {
       var imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 12.0
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
    var categoryView: UIView = {
        var categoryView = UIView()
        categoryView.backgroundColor = UIColor(named: "7E2DFC button")
        categoryView.layer.cornerRadius = 8
        return categoryView
    }()
    
    var categoryLabel: UILabel = {
       var categoryLabel = UILabel()
        categoryLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        categoryLabel.textColor = UIColor.white
        return categoryLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(imageview)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(categoryView)
        contentView.addSubview(categoryLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func setupConstraints(){
       imageview.snp.makeConstraints { make in
           make.top.horizontalEdges.equalToSuperview()
           make.height.equalTo(164)
       }
       titleLabel.snp.makeConstraints { make in
           make.top.equalTo(imageview.snp.bottom).inset(-16)
           make.horizontalEdges.equalToSuperview()
       }
       subtitleLabel.snp.makeConstraints { make in
           make.top.equalTo(titleLabel.snp.bottom).inset(-8)
           make.horizontalEdges.equalToSuperview()
           make.bottom.equalToSuperview()
       }
       categoryView.snp.makeConstraints { make in
           make.top.equalToSuperview().inset(8)
           make.left.equalTo(imageview.snp.left).inset(8)
           make.height.equalTo(24)
       }
       categoryLabel.snp.makeConstraints { make in
           make.centerY.equalTo(categoryView)
           make.horizontalEdges.equalTo(categoryView.snp.horizontalEdges).inset(8)
       }
    }
    
    func setData(bannerMovie: BannerMovie ){
        let transformer = SDImageResizingTransformer(size: CGSize(width: 300, height: 164), scaleMode: .aspectFill)
        imageview.sd_setImage(with: URL(string: bannerMovie.link), placeholderImage: nil, context: [.imageTransformer: transformer])
        
        if let categoryName = bannerMovie.movie.categories.first?.name{
            categoryLabel.text = categoryName
            
        }
       
        titleLabel.text = bannerMovie.movie.name
        subtitleLabel.text = bannerMovie.movie.description
    }

}
