//
//  LanguageViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 26.02.2024.
//

import UIKit
import Localize_Swift

protocol LanguageProtocol{
    func languageDidChange()
}

class LanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    
    var delegate : LanguageProtocol?
    let languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    
    var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "white-1C2431")
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    var shortView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-6B7280(shortView)")
        return view
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "LANGUAGE".localized()
        label.font =  UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-White(view, font etc)")
        return label
    }()
    
   lazy var tableview: UITableView = {
       var tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true,completion: nil)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: backgroundView))!{
        return false
        }
        return true
    }
    
//    MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        
        let label = UILabel()
        label.text = languageArray[indexPath.row][0]
        label.font =  UIFont(name: "SFProDisplay-Semibold", size: 16)
        label.textColor = UIColor(named: "111827-White(view, font etc)")
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.centerY.equalToSuperview()
        }
        
        let checkImageView = UIImageView()
        checkImageView.contentMode = .scaleAspectFill
        checkImageView.clipsToBounds = true
        cell.contentView.addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(adaptiveSize(for: 24))
        }
        if Localize.currentLanguage() == languageArray[indexPath.row][1]{
            checkImageView.image = UIImage(named: "Check")
        }else{
            checkImageView.image = nil
            checkImageView.snp.removeConstraints()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Localize.setCurrentLanguage(languageArray[indexPath.row][1])
        delegate?.languageDidChange()
        dismiss(animated: true,completion: nil)
    }

}

extension LanguageViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "50-30%")
        view.addSubview(backgroundView)
        backgroundView.addSubview(shortView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(tableview)
    }
    func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(adaptiveHeight(for: 303))
        }
        shortView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(adaptiveSize(for: 21))
            make.height.equalTo(5)
            make.width.equalTo(adaptiveSize(for: 64))
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(shortView.snp.bottom).inset(-24)
        }
        tableview.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(titleLabel.snp.bottom).inset(adaptiveSize(for: -12))
        }
    }
}
