//
//  ProfileViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 10.02.2024.
//

import UIKit
import SnapKit
import Localize_Swift

class ProfileViewController: UIViewController, LanguageProtocol{
    
    var viewForAvatar: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "white-1C2431")
        return view
    }()
    var avatarImageView: UIImageView = {
       var imageview = UIImageView()
        imageview.image = UIImage(named: "Avatar")
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    var myProfileLabel: UILabel = {
       var label = UILabel()
//        label.text = "MY_PROFILE".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-White(view, font etc)")
        return label
    }() 
    var emailLabel: UILabel = {
       var label = UILabel()
//        label.text = "MY_PROFILE".localized()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()

    var viewForButtons: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "F9FAFB-111827")
        return view
    }()
//    MARK: - UI for PERSONAL INFO
    var personalInfoButton: UIButton = {
       var button = UIButton()
//        button.setTitle("PERSONAL_INFO".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "1C2431-E5E7EB"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.titleLabel?.snp.makeConstraints({ make in
            make.left.equalTo(button.snp.left)
        })
        button.addTarget(self, action: #selector(showPersonalInfoVC), for: .touchUpInside)
        return button
      }()
    
    var labelForPersonalInfo: UILabel = {
        var label = UILabel()
//        label.text = "CHANGE".localized()
        label.font =  UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
       
        return label
    }()
   
    var arrowImageview: UIImageView = {
        var imageview = UIImageView()
        imageview.image = UIImage(named: "arrow")
        imageview.contentMode = .scaleAspectFill
        return imageview
   }()
    var stackForPersonalLabelAndArrow: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    var viewUnderPersonalInfo: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }()
//    MARK: - UI for CHANGE PASSWORD
    
    lazy var changePasswordButton: UIButton = {
       var button = UIButton()
        
//        button.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        button.setTitleColor(UIColor(named: "1C2431-E5E7EB"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(named: "F9FAFB-111827")
        button.titleLabel?.snp.makeConstraints({ make in
            make.left.equalTo(button.snp.left)
        })
        button.addTarget(self, action: #selector(showchangePasswordVC), for: .touchUpInside)
        return button
      }()
    
    var arrowImageviewForChangePassword: UIImageView = {
        var imageview = UIImageView()
        imageview.image = UIImage(named: "arrow")
        imageview.contentMode = .scaleAspectFill
        return imageview
   }()
    
    var viewUnderChangePassword: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }()
//      MARK: - UI for LANGUAGE CHANGE
    
    lazy var languageButton: UIButton = {
        var button = UIButton()
//         button.setTitle("LANGUAGE".localized(), for: .normal)
         button.setTitleColor(UIColor(named: "1C2431-E5E7EB"), for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
         button.backgroundColor = UIColor(named: "F9FAFB-111827")
         button.titleLabel?.snp.makeConstraints({ make in
            make.left.equalTo(button.snp.left)
        })
        button.addTarget(self, action: #selector(showLanguageVC), for: .touchUpInside)
       return button
       }()  
   
    var labelForLanguage: UILabel = {
        var label = UILabel()
        label.font =  UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
       
        return label
    }()
   
    var arrowImageviewForLanguage: UIImageView = {
        var imageview = UIImageView()
        imageview.image = UIImage(named: "arrow")
        imageview.contentMode = .scaleAspectFill
        return imageview
   }()
    var stackForLanguageLabelAndArrow: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    var viewUnderLanguage: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }()
    
//      MARK: - UI for DARK MODE
    
    lazy var darkModeButton: UIButton = {
        var button = UIButton()
//         button.setTitle("DARK_MODE".localized(), for: .normal)
         button.setTitleColor(UIColor(named: "1C2431-E5E7EB"), for: .normal)
         button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
         button.backgroundColor = UIColor(named: "F9FAFB-111827")
        button.titleLabel?.snp.makeConstraints({ make in
           make.left.equalTo(button.snp.left)
       })

         return button
       }()
    
    lazy var `switch`: UISwitch = {
        var `switch` = UISwitch()
        `switch`.onTintColor = UIColor(named: "B376F7 (currentPageC)")
        `switch`.thumbTintColor = .white
        `switch`.addTarget(self, action: #selector(switchChange), for: .valueChanged)
        `switch`.isOn = false
        return `switch`
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = UserDefaults.standard.string(forKey: "email"){
            emailLabel.text = email
        }
        setupView()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        configureLanguage()
    }
  
 
    @objc  func exit() {
        let existVC = ExitViewController()
        existVC.modalPresentationStyle = .overFullScreen
        present(existVC, animated: true,completion: nil)
        
    }
    @objc func showPersonalInfoVC() {
        let personalinfoVC = PersonalInfoViewController()
        navigationController?.pushViewController(personalinfoVC, animated: true)
    }       
    @objc func showchangePasswordVC() {
        let changePassVC = ChangePasswordViewController()
        navigationController?.pushViewController(changePassVC, animated: true)
    }
    @objc func showLanguageVC() {
        let languageVC = LanguageViewController()
        languageVC.modalPresentationStyle = .overFullScreen
        languageVC.delegate = self
        present(languageVC, animated: true,completion: nil)
    }
    @objc func switchChange(_ sender: UISwitch){
        if let window = view.window {
            window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
        }
    }
}

extension ProfileViewController {
    func configureLanguage(){
        myProfileLabel.text = "MY_PROFILE".localized()
        emailLabel.text = "MY_PROFILE".localized()
        personalInfoButton.setTitle("PERSONAL_INFO".localized(), for: .normal)
        labelForPersonalInfo.text = "CHANGE".localized()
        changePasswordButton.setTitle("CHANGE_PASSWORD".localized(), for: .normal)
        languageButton.setTitle("LANGUAGE".localized(), for: .normal)
        darkModeButton.setTitle("DARK_MODE".localized(), for: .normal)
        
        if Localize.currentLanguage() == "ru"{
            labelForLanguage.text = "Русский"
        }
        if Localize.currentLanguage() == "kk"{
            labelForLanguage.text = "Қазақша"
        }
        if Localize.currentLanguage() == "en"{
            labelForLanguage.text = "English"
        }
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        navigationItem.title = "PROFILE".localized()
        view.addSubview(viewForAvatar)
        viewForAvatar.addSubview(avatarImageView)
        viewForAvatar.addSubview(myProfileLabel)
        viewForAvatar.addSubview(emailLabel)
        
//        view.addSubview(avatarImageView)
//        view.addSubview(myProfileLabel)
//        view.addSubview(emailLabel)
        view.addSubview(viewForButtons)
        viewForButtons.addSubview(personalInfoButton)
        viewForButtons.addSubview(changePasswordButton)
        viewForButtons.addSubview(languageButton)
        viewForButtons.addSubview(darkModeButton)
        viewForButtons.addSubview(stackForPersonalLabelAndArrow)
        stackForPersonalLabelAndArrow.addArrangedSubview(labelForPersonalInfo)
        stackForPersonalLabelAndArrow.addArrangedSubview(arrowImageview)
        viewForButtons.addSubview(viewUnderPersonalInfo)
        viewForButtons.addSubview(changePasswordButton)
        viewForButtons.addSubview(arrowImageviewForChangePassword)
        viewForButtons.addSubview(viewUnderChangePassword)
        viewForButtons.addSubview(languageButton)
        viewForButtons.addSubview(stackForLanguageLabelAndArrow)
        stackForLanguageLabelAndArrow.addArrangedSubview(labelForLanguage)
        stackForLanguageLabelAndArrow.addArrangedSubview(arrowImageviewForLanguage)
        viewForButtons.addSubview(viewUnderLanguage)
        viewForButtons.addSubview(darkModeButton)
        viewForButtons.addSubview(`switch`)
     
        let existButtonitem = UIBarButtonItem(image: UIImage(named: "Exist"), style: .plain, target: self, action: #selector(exit))
        existButtonitem.tintColor = UIColor(named: "FF402B (error)")
        self.navigationItem.rightBarButtonItem = existButtonitem
    }
  
    func languageDidChange() {
        configureLanguage()
    }

    func setupConstraints() {
        viewForAvatar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(adaptiveSize(for: 227))
        }
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(adaptiveHeight(for: 104))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        myProfileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).inset(adaptiveSize(for: -24))
        }
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(myProfileLabel.snp.bottom).inset(adaptiveSize(for: -8))
        }
        viewForButtons.snp.makeConstraints { make in
            make.top.equalTo(viewForAvatar.snp.bottom)
           make.horizontalEdges.equalToSuperview()
           make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        personalInfoButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalToSuperview()
            make.height.equalTo(adaptiveHeight(for: 63))
        }
        stackForPersonalLabelAndArrow.snp.makeConstraints { make in
            make.centerY.equalTo(personalInfoButton)
            make.right.equalTo(personalInfoButton.snp.right)
        }
        viewUnderPersonalInfo.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(personalInfoButton.snp.bottom)
        }
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(viewUnderPersonalInfo.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(adaptiveHeight(for: 63))
        }
        arrowImageviewForChangePassword.snp.makeConstraints { make in
            make.centerY.equalTo(changePasswordButton)
            make.right.equalTo(changePasswordButton.snp.right)
        }
        viewUnderChangePassword.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(changePasswordButton.snp.bottom)
        }
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(viewUnderChangePassword.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(adaptiveHeight(for: 63))
        }
        stackForLanguageLabelAndArrow.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton)
            make.right.equalTo(languageButton.snp.right)
        }
        viewUnderLanguage.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(languageButton.snp.bottom)
        }
        darkModeButton.snp.makeConstraints { make in
            make.top.equalTo(viewUnderLanguage.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(adaptiveHeight(for: 63))
        }
        `switch`.snp.makeConstraints { make in
            make.centerY.equalTo(darkModeButton)
            make.right.equalTo(darkModeButton.snp.right)
            make.height.equalTo(32)
            make.width.equalTo(52)
        }
    }
}
