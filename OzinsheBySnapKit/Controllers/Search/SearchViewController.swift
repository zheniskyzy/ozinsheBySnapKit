//
//  SearchViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 10.02.2024.
//

import UIKit
import SnapKit
import Localize_Swift
import SVProgressHUD
import Alamofire
import SwiftyJSON

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}


class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource{
    
    var categories: [Category] = []
    var movies: [Movie] = []
    
    var searchTextfield: UITextField = {
       var textfield = UITextField()
        textfield.placeholder = "SEARCH".localized()
        textfield.textColor = UIColor(named: "111827-White(view, font etc)")
        textfield.backgroundColor = UIColor(named: "White-111827(view, font etc)")
//        textfield.layer.borderColor = UIColor(named: "E5EBF0-1C2431(border)")?.cgColor
        textfield.borderStyle = .none
        textfield.layer.cornerRadius = 12.0
        textfield.layer.borderWidth = 1.0
        textfield.addTarget(self, action: #selector(didBegin), for: .editingDidBegin)
        textfield.addTarget(self, action: #selector(didEnd), for: .editingDidEnd)
        textfield.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textfield
    }()
    
   lazy var searchButton: UIButton = {
       var button = UIButton()
        button.setImage(UIImage(named: "searchButton"), for: .normal)
        button.frame.size = CGSize(width: 56, height: 56)
        button.addAction(UIAction(handler: { _ in
            self.downloadSearchMovies()
        }), for: .touchUpInside)
        return button
    }()
    
    var stackViewForSearch: UIStackView = {
       var stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 16
        return stackview
    }()
    var categoriesLabel: UILabel = {
       var label = UILabel()
        label.text = "CATEGORIES".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-White(view, font etc)")
        return label
    }()
   lazy var clearButton: UIButton = {
       var button = UIButton()
        button.setImage(UIImage(named: "clearIcon"), for: .normal)
       button.addTarget(self, action: #selector(clear), for: .touchDown)
        return button
    }()
    
    lazy  var collectionView: UICollectionView = {
      var layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 120
        layout.estimatedItemSize.height = 34
        layout.scrollDirection = .vertical
      var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collectionView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
          collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
          collectionView.isScrollEnabled = true
          collectionView.showsHorizontalScrollIndicator = false
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.isUserInteractionEnabled = true
          return collectionView
      }()
   lazy var tableView: UITableView = {
       var tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
//    var tableViewToLabelConstraint: NSLayoutConstraint!
//    var tableViewCollectionConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        view.addSubview(stackViewForSearch)
        stackViewForSearch.addArrangedSubview(searchTextfield)
        stackViewForSearch.addArrangedSubview(searchButton)
        view.addSubview(categoriesLabel)
        view.addSubview(clearButton)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        
        clearButton.isHidden = true
        setupConstraints()
        downloadCategories()
    }
    
    
    // MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.layer.cornerRadius = 8.0
        let label = UILabel()
        label.text = categories[indexPath.row].name
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        cell.contentMode = .scaleAspectFit
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.backgroundColor = UIColor(named: "F3F4F6-374151")
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 16))
            make.centerY.equalToSuperview()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let categoryTableViewController =  CategoryTableViewController()
        categoryTableViewController.categoryID = categories[indexPath.row].id
        categoryTableViewController.navigationItem.title = categories[indexPath.row].name
        navigationController?.show(categoryTableViewController, sender: self)
    }
    
//   MARK: - tableView
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
    
        cell.setData(movie: movies[indexPath.row])
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieinfoVC = DetailViewController()
        movieinfoVC.movie  = movies[indexPath.row]
        navigationController?.show(movieinfoVC, sender: self)
    }
}
extension SearchViewController {
    @objc func clear() {
        searchTextfield.text = ""
        downloadSearchMovies()
    }
    
    @objc func didBegin(){
        searchTextfield.layer.borderColor = UIColor(named: "9753F0 (border)")?.cgColor
        searchButton.setImage(UIImage(named: "searchSelected"), for: .normal)
    }
    @objc func didEnd(){
        searchTextfield.layer.borderColor = UIColor(named: "E5EBF0-374151 borderTF")?.cgColor
        searchButton.setImage(UIImage(named: "searchButton"), for: .normal)
    }
    @objc func textFieldEditingChanged() {
        
        downloadSearchMovies()
    }
    
    // MARK: - downloadCategories
    func downloadCategories(){
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.CATEGORIES_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200{
                
                let json = JSON(response.data!)
                    print("JSON: \(json)")
                    
                    if let array = json.array{
                        for item in array{
                            let category = Category(json: item)
                            self.categories.append(category)
                        }
                        self.collectionView.reloadData()
                    }else{
                        var ErrorString = "CONNECTION_ERROR".localized()
                        if let sCode = response.response?.statusCode{
                            ErrorString = ErrorString + "\(sCode)"
                        }
                        ErrorString = ErrorString + "\(resultString)"
                        SVProgressHUD.showError(withStatus: "\(ErrorString)")
                    }
            }
        }
    }

    //MARK: - downloadSearchMovies
    func downloadSearchMovies(){
    
        if searchTextfield.text!.isEmpty{
            categoriesLabel.text = "CATEGORIES".localized()
            collectionView.isHidden = false
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(collectionView.snp.bottom)
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            tableView.isHidden = true
            movies.removeAll()
            tableView.reloadData()
            clearButton.isHidden = true
            return
        }else{
            categoriesLabel.text = "SEARCH_RESULT".localized()
            collectionView.isHidden = true
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(categoriesLabel.snp.bottom).inset(-10)
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            tableView.isHidden = false
            clearButton.isHidden = false
        }
        
        SVProgressHUD.show()
        
        let parameters = ["search": searchTextfield.text!]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.SEARCH_MOVIES_URL, method: .get,parameters: parameters, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200{
                
                let json = JSON(response.data!)
                    print("JSON: \(json)")
                    
                    if let array = json.array{
                        self.movies.removeAll()
                        self.tableView.reloadData()
                        for item in array{
                            let movie = Movie(json: item)
                            self.movies.append(movie)
                        }
                        self.tableView.reloadData()
                    }else{
                        var ErrorString = "CONNECTION_ERROR".localized()
                        if let sCode = response.response?.statusCode{
                            ErrorString = ErrorString + "\(sCode)"
                        }
                        ErrorString = ErrorString + "\(resultString)"
                        SVProgressHUD.showError(withStatus: "\(ErrorString)")
                }
            }
        }
    }
    
    func setupConstraints(){
        stackViewForSearch.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(view.safeAreaLayoutGuide).inset(adaptiveSize(for: 24))
        }
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(stackViewForSearch.snp.bottom).inset(adaptiveSize(for: -35))
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        clearButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextfield)
            make.width.height.equalTo(56)
            make.right.equalTo(searchTextfield.snp.right)
        }
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(adaptiveHeight(for: 400))
            make.top.equalTo(categoriesLabel.snp.bottom)
            
        }
        tableView.snp.makeConstraints { make in
//            make.top.equalTo(categoriesLabel.snp.bottom).inset(-10)
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}
