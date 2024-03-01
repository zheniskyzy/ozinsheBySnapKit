//
//  HistoryTableViewCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 21.02.2024.
//

import UIKit
import SnapKit
import SDWebImage
import Localize_Swift

class HistoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
  
    var mainMovies = MainMovies()
    var delegate : MovieProtocol?
    
    var categoryNameLabel: UILabel = {
       var categoryNameLabel = UILabel()
        categoryNameLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        categoryNameLabel.textColor = UIColor(named: "111827-White(view, font etc)")
        return categoryNameLabel
    }()
    
    lazy var collectionview: UICollectionView = {
        
     let layout = TopAlignedCollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.minimumLineSpacing = 16
         layout.minimumInteritemSpacing = 16
         layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
         layout.estimatedItemSize.width = 184
         layout.estimatedItemSize.height = 112
    var  collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionview.backgroundColor = UIColor(named: "White-111827(view, font etc)")
         collectionview.dataSource = self
         collectionview.delegate = self
         collectionview.isPagingEnabled = true
         collectionview.isScrollEnabled = true
         collectionview.showsHorizontalScrollIndicator = false
         collectionview.bounces = false
         collectionview.translatesAutoresizingMaskIntoConstraints = false
         collectionview.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "historyCell")
    
         return collectionview
     }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(collectionview)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        categoryNameLabel.text = "CONTINUE_WATCHING".localized()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(mainMovie: MainMovies){
        self.mainMovies = mainMovie
        collectionview.reloadData()
    }
    
    //MARK: - collectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovies.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as! HistoryCollectionViewCell
        
        // imageview
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
         
        cell.imageview.sd_setImage(with: URL(string: mainMovies.movies[indexPath.row].poster_link), placeholderImage: nil, context: [.imageTransformer: transformer])
        
        cell.titleLabel.text = mainMovies.movies[indexPath.row].name
    
        if let genrename = mainMovies.movies[indexPath.row].genres.first{
            cell.subtitleLabel.text = genrename.name
        }else{
            cell.subtitleLabel.text = ""
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovies.movies[indexPath.row])
    }
    
}

extension HistoryTableViewCell {
    
    func setupConstraints(){
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.equalToSuperview().inset(24)
        }
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(categoryNameLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
