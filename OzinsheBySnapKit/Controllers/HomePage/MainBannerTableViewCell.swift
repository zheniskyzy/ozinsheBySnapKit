//
//  MainBannerTableViewCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 20.02.2024.
//

import UIKit
import SnapKit

class MainBannerTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var mainMovie = MainMovies()
    var delegate : MovieProtocol?
    
   lazy var collectionview: UICollectionView = {
       
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 10.0, right: 24.0)
        layout.estimatedItemSize.width = 300
        layout.estimatedItemSize.height = 218
    
   var  collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.isPagingEnabled = true
        collectionview.isScrollEnabled = true
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.bounces = false
        collectionview.register(bannerCollectionViewCell.self, forCellWithReuseIdentifier: "bannerCell")
        return collectionview
    }()
    

    
    override init(style: MainTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(collectionview)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.bannerMovie.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! bannerCollectionViewCell
        
        cell.setData(bannerMovie: mainMovie.bannerMovie[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.bannerMovie[indexPath.row].movie)
    }
}



extension MainBannerTableViewCell {
    func setData(mainMovie: MainMovies){
        self.mainMovie = mainMovie
        collectionview.reloadData()
    }
    
    func setupConstraints(){
        collectionview.snp.makeConstraints { make in
            make.top.bottom.horizontalEdges.equalToSuperview()
        }
    }
}
