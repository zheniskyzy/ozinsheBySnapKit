//
//  MainTableViewCell.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 20.02.2024.
//

import UIKit
import SDWebImage
import Localize_Swift

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

        attributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.forEach { minY, line in
                line.forEach {
                    $0.frame = $0.frame.offsetBy(
                        dx: 0,
                        dy: minY - $0.frame.origin.y
                    )
                }
            }

        return attributes
    }
}


class MainTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var mainMovie = MainMovies()
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
         layout.minimumLineSpacing = 10
         layout.minimumInteritemSpacing = 10
         layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
         layout.estimatedItemSize.width = 184
         layout.estimatedItemSize.height = 156
     
    var  collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionview.backgroundColor = UIColor(named: "White-111827(view, font etc)")
         collectionview.dataSource = self
         collectionview.delegate = self
         collectionview.isPagingEnabled = true
         collectionview.isScrollEnabled = true
         collectionview.showsHorizontalScrollIndicator = false
         collectionview.bounces = false
         collectionview.translatesAutoresizingMaskIntoConstraints = false
         collectionview.register(ByCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "mainCollectionCell")
    
         return collectionview
     }()
    
    var button: UIButton = {
       var button = UIButton()
        button.setTitle("MORE".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "B376F7 (currentPageC)"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
       
        return button
    }()
    
    override init(style: MainTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(collectionview)
        contentView.addSubview(button)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(mainMovie: MainMovies){
        categoryNameLabel.text = mainMovie.categoryName
        
        self.mainMovie = mainMovie
        collectionview.reloadData()
    }
    
    //MARK: - collectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCollectionCell", for: indexPath) as! ByCategoryCollectionViewCell
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 112, height: 164), scaleMode: .aspectFill)
        cell.imageview.sd_setImage(with: URL(string: mainMovie.movies[indexPath.row].poster_link), placeholderImage: nil, context: [.imageTransformer: transformer])
        cell.titleLabel.text = mainMovie.movies[indexPath.row].name
        
        if let genreName = mainMovie.movies[indexPath.row].genres.first{
            cell.subtitleLabel.text = genreName.name
        }else{
            cell.subtitleLabel.text = ""
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
    }

}
extension MainTableViewCell {
   
    func setupConstraints(){
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.equalToSuperview().inset(24)
        }
        collectionview.snp.makeConstraints { make in
//            make.top.equalTo(categoryNameLabel.snp.bottom).inset(-16)
            make.top.equalTo(categoryNameLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.centerY.equalTo(categoryNameLabel)
            make.right.equalToSuperview().inset(24)
        }
    }
}
