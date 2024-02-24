//
//  DetailViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 21.02.2024.
//

import UIKit
import SnapKit
import Localize_Swift
import SVProgressHUD
import Alamofire
import SDWebImage
import SwiftyJSON

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
  
    var movie = Movie()
    var screenshots: [Screenshot] = []
    
    var scrollView: UIScrollView = {
       var scrollview = UIScrollView()
           scrollview.backgroundColor = .clear
           scrollview.showsVerticalScrollIndicator = true
           scrollview.isScrollEnabled = true
           scrollview.clipsToBounds = true
           scrollview.contentMode = .scaleAspectFill
           scrollview.contentInsetAdjustmentBehavior = .never
        return scrollview
    }()
    
    var contentview: UIView = {
        var view = UIView()
            view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        return view
    }()
    
    var posterImageView: UIImageView = {
       var imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var gradientView: GradientView = {
       var gradientView = GradientView()
           gradientView.startColor = UIColor(named: "gradientForPoster")!
           gradientView.endColor = UIColor(named: "0F161D endGradient")!
        return gradientView
    }()
    
    var shareButton: UIButton = {
       var button = UIButton()
           button.setImage(UIImage(named: "share"), for: .normal)
           button.addTarget(self, action: #selector(share), for: .touchUpInside)
        return button
    }()
    
    var favoriteButton: UIButton = {
        var button = UIButton()
            button.setImage(UIImage(named: "favoriteButton"), for: .normal)
            button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
         return button
    }()
    
    var playButton: UIButton = {
        var button = UIButton()
            button.setImage(UIImage(named: "play"), for: .normal)
            button.addTarget(self, action: #selector(playMovie), for: .touchUpInside)
         return button
    }()
    
    var favoriteLabel: UILabel = {
        var label = UILabel()
            label.text = "ADD_TO_FAVORITE".localized()
            label.textColor = UIColor(named: "D1D5DB-9CA3AF")
            label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
            return label
    }() 
    
    var shareLabel: UILabel = {
        var label = UILabel()
            label.text = "SHARE".localized()
            label.textColor = UIColor(named: "D1D5DB-9CA3AF")
            label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
            return label
    }()
    
    var backgroundView: UIView = {
        var view = UIView()
            view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
            view.layer.cornerRadius = 32.0
            view.clipsToBounds = true
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            return view
    }()
    
    var nameLabel: UILabel = {
       var label = UILabel()
            label.textColor = UIColor(named: "111827-White(view, font etc)")
            label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
            return label
    }()
    
    var detailLabel: UILabel = {
       var label = UILabel()
            label.textColor = UIColor(named: "9CA3AF")
            label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
            return label
    }()
    
    var viewforline1: UIView = {
        var view = UIView()
            view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
            return view
    }()
    
    var descriptionLabel: UILabel = {
       var label = UILabel()
            label.textColor = UIColor(named: "9CA3AF-E5E7EB")
            label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
            label.numberOfLines = 4
            return label
    }()
    
    var descriptionGradient: GradientView = {
        var gradientView = GradientView()
             gradientView.startColor = UIColor(named: "transparent")!
             gradientView.endColor = UIColor(named: "White-111827(view, font etc)")!
             return gradientView
    }()
    
    var fullButton: UIButton = {
        var button = UIButton()
            button.setTitle("READ_MORE".localized(), for: .normal)
            button.setTitleColor(UIColor(named: "B376F7 (currentPageC)"), for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            button.addTarget(self, action: #selector(fullDescription), for: .touchDown)
            return button
    }()
    
    var directorLabelStatic: UILabel = {
       var label = UILabel()
            label.text = "DIRECTOR".localized()
            label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
            label.textColor = UIColor(named: "4B5563")
            return label
    }()
    
    var produserLabelStatic: UILabel = {
       var label = UILabel()
            label.text = "PRODUCER".localized()
            label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
            label.textColor = UIColor(named: "4B5563")
            return label
        }()
    
    var directorLabel: UILabel = {
        var label = UILabel()
             label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
             label.textColor = UIColor(named: "9CA3AF")
             return label
    }()
    
    var producerLabel: UILabel = {
        var label = UILabel()
             label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
             label.textColor = UIColor(named: "9CA3AF")
             return label
    }()
    
    var stackViewProducer: UIStackView = {
       var stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 19
            return stackView
    }()
    
    var stackViewDirector: UIStackView = {
       var stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 19
            return stackView
    }()
    
    var viewforline2: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }()
    
    var seasonsLabel: UILabel = {
        var label = UILabel()
        label.text = "DEPARTMENTS".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-White(view, font etc)")
        
        return label
    }()
    
    var seasonsButton: UIButton = {
       var button = UIButton()
        button.setTitle("5 сезон, 46 серия", for: .normal)
        button.setTitleColor(UIColor(named: "9CA3AF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.addTarget(self, action: #selector(showMore), for: .touchDown)
        return button
    }()
    
    var arrowButton: UIButton = {
        var button = UIButton()
        button.frame.size = CGSize(width: 16, height: 16)
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(showMore), for: .touchDown)
        return button
    }()
    
    var stackForSeasonsButton: UIStackView = {
       var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    var screenshotLabel: UILabel = {
       var label = UILabel()
        label.text = "SCREENSHOTS".localized()
        label.textColor = UIColor(named: "111827-White(view, font etc)")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        return label
    }()
    
  lazy var screenshotCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.sectionInset.left = 24
        layout.sectionInset.right = 24
        layout.scrollDirection = .horizontal
      layout.estimatedItemSize.width = 184
      layout.estimatedItemSize.height = 112
        
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: "screenshotsCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        view.addSubview(scrollView)
        scrollView.addSubview(contentview)
        contentview.addSubview(posterImageView)
        contentview.addSubview(gradientView)
        contentview.addSubview(shareButton)
        contentview.addSubview(favoriteButton)
        contentview.addSubview(playButton)
        contentview.addSubview(favoriteLabel)
        contentview.addSubview(shareLabel)
        contentview.addSubview(backgroundView)
        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(detailLabel)
        backgroundView.addSubview(viewforline1)
        backgroundView.addSubview(descriptionLabel)
        backgroundView.addSubview(descriptionGradient)
        backgroundView.addSubview(fullButton)
        backgroundView.addSubview(stackViewDirector)
        stackViewDirector.addArrangedSubview(directorLabelStatic)
        stackViewDirector.addArrangedSubview(directorLabel)
        backgroundView.addSubview(stackViewProducer)
        stackViewProducer.addArrangedSubview(produserLabelStatic)
        stackViewProducer.addArrangedSubview(producerLabel)
        backgroundView.addSubview(viewforline2)
        backgroundView.addSubview(seasonsLabel)
        backgroundView.addSubview(stackForSeasonsButton)
        stackForSeasonsButton.addArrangedSubview(seasonsButton)
        stackForSeasonsButton.addArrangedSubview(arrowButton)
        backgroundView.addSubview(screenshotLabel)
        backgroundView.addSubview(screenshotCollectionView)
        
        self.tabBarController?.tabBar.isHidden = true
        setupConstraints()
        configureViews()
        setData()
        downloadScreenshots()
        
        if descriptionLabel.maxNumberOfLines < 5 {
            fullButton.isHidden = true
            stackViewDirector.snp.remakeConstraints { make in
                make.left.equalToSuperview().inset(adaptiveSize(for: 24))
                make.top.equalTo(descriptionLabel.snp.bottom).inset(adaptiveSize(for: -5))
            }
        }
    }

    @objc func fullDescription(){
        if descriptionLabel.numberOfLines > 4 {
           descriptionLabel.numberOfLines = 4
           descriptionGradient.isHidden = false
        } else {
           descriptionLabel.numberOfLines = 30
           fullButton.setTitle("HIDE".localized(), for: .normal)
           descriptionGradient.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenshotsCell", for: indexPath) as! ScreenshotCollectionViewCell
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        cell.imageview.sd_setImage(with: URL(string: screenshots[indexPath.row].link), placeholderImage: nil, context: [.imageTransformer: transformer])

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showVC = ScreenshotShowViewController()
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        showVC.imageview.sd_setImage(with: URL(string: screenshots[indexPath.row].link), placeholderImage: nil, context: [.imageTransformer: transformer])
        navigationController?.pushViewController(showVC, animated: true)
    }
}

extension DetailViewController {
    
    @objc func share() {
        let text = "\(movie.name) \n\(movie.description)"
        let image = posterImageView.image
        let shareAll = [text, image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        // вспылающее окно где можно отправить либо скопировать и тд
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func downloadScreenshots() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.GET_SECREENSHOTS + String(movie.id), method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
              
                if let array = json.array {
                    for item in array {
                        let screen = Screenshot(json: item)
                        self.screenshots.append(screen)
                    }
                    self.screenshotCollectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    @objc func addToFavorite() {
        var method = HTTPMethod.post
        if movie.favorite {
            method = .delete
        }
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        let parameters = ["movieId": movie.id] as [String : Any]
        
        AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                 self.movie.favorite.toggle()
                self.configureViews()
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode {
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
   @objc func playMovie(){
        if movie.movieType == "MOVIE" {
            let playerVC = MoviePlayerViewController()
            playerVC.video_link = movie.video_link
            navigationController?.pushViewController(playerVC, animated: true)
            
        } else {
            let seasonsVC = SeasonsSeriesViewController()
            seasonsVC.movie = movie
            navigationController?.pushViewController(seasonsVC, animated: true)
        }
    }
    
    @objc func showMore(){
        if movie.movieType == "MOVIE" {
            let playerVC = MoviePlayerViewController()
            playerVC.video_link = movie.video_link
            navigationController?.pushViewController(playerVC, animated: true)
        } else {
            let seasonsVC = SeasonsSeriesViewController()
            seasonsVC.movie = movie
            navigationController?.pushViewController(seasonsVC, animated: true)
        }
    }
    
    func configureViews(){
        if movie.movieType == "MOVIE" {
           seasonsLabel.isHidden = true
           seasonsButton.isHidden = true
            arrowButton.isHidden = true
        }else{
        seasonsButton.setTitle("\(movie.seasonCount) сезон, \(movie.seriesCount) серия", for: .normal)
        }
        
        if movie.favorite{
            favoriteButton.setImage(UIImage(named: "favoriteSelected"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "favoriteButton"), for: .normal)
        }
    }
    
    func setData() {
        posterImageView.sd_setImage(with: URL(string: movie.poster_link), completed: nil)
        nameLabel.text = movie.name
        detailLabel.text = "\(movie.year)"
        
        for item in movie.genres {
            detailLabel.text = detailLabel.text! + " • " + item.name
        }
          descriptionLabel.text = movie.description
          directorLabel.text = movie.director
          producerLabel.text = movie.producer
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentview.snp.makeConstraints { make in
            make.horizontalEdges.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(adaptiveHeight(for: 364))
        }
        gradientView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(adaptiveHeight(for: 364))
        }
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(adaptiveSize(for: 37))
            make.centerY.equalTo(favoriteButton)
            make.height.width.equalTo(adaptiveSize(for: 100))
            make.top.equalToSuperview().inset(adaptiveSize(for: 228))
        }
        favoriteButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(adaptiveSize(for: 37))
            make.height.width.equalTo(adaptiveSize(for: 100))
            make.top.equalToSuperview().inset(adaptiveSize(for: 228))
        }
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(adaptiveSize(for: 132))
            make.top.equalToSuperview().inset(adaptiveSize(for: 198))
        }
        favoriteLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favoriteButton)
            make.top.equalTo(favoriteButton.snp.bottom).inset(adaptiveSize(for: 46))
        }
        shareLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shareButton)
            make.top.equalTo(shareButton.snp.bottom).inset(adaptiveSize(for: 46))
        }
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(gradientView.snp.top).inset(adaptiveSize(for: 324))
            make.top.equalTo(posterImageView.snp.top).inset(adaptiveSize(for: 324))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(adaptiveSize(for: -8))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        viewforline1.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).inset(adaptiveSize(for: -24))
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(viewforline1.snp.bottom).inset(adaptiveSize(for: -24))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        descriptionGradient.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.top)
            make.bottom.equalTo(fullButton.snp.top)
        }
        fullButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(descriptionGradient.snp.bottom)
            make.top.equalTo(descriptionLabel.snp.bottom).inset(adaptiveSize(for: -16))
        }
        stackViewDirector.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(fullButton.snp.bottom).inset(adaptiveSize(for: -24))
        }
        stackViewProducer.snp.makeConstraints { make in
            make.top.equalTo(stackViewDirector.snp.bottom).inset(adaptiveSize(for: -8))
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        viewforline2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(stackViewProducer.snp.bottom).inset(adaptiveSize(for: -24))
        }
        
        if movie.movieType == "MOVIE" {
            seasonsLabel.isHidden = true
            seasonsButton.isHidden = true
            arrowButton.isHidden = true
            screenshotLabel.snp.remakeConstraints { make in
                make.left.equalToSuperview().inset(adaptiveSize(for: 24))
                make.top.equalTo(viewforline2.snp.bottom).inset(adaptiveSize(for: -32))
            }
        }else{
            seasonsLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(adaptiveSize(for: 24))
                make.top.equalTo(viewforline2.snp.bottom).inset(adaptiveSize(for: -24))
            }
            stackForSeasonsButton.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(adaptiveSize(for: 24))
                make.centerY.equalTo(seasonsLabel)
                make.left.equalTo(seasonsLabel.snp.right)
            }

            screenshotLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().inset(adaptiveSize(for: 24))
                make.top.equalTo(seasonsLabel.snp.bottom).inset(adaptiveSize(for: -32))
            }
        }
        screenshotCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(112)
            make.top.equalTo(screenshotLabel.snp.bottom).inset(adaptiveSize(for: -16))
            make.bottom.equalToSuperview().inset(adaptiveSize(for: 24))
        }
    }
}

