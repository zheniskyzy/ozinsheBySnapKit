//
//  ChangePasswordViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 28.02.2024.
//

import UIKit
import Localize_Swift
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class ChangePasswordViewController: UIViewController {

    var passwordTextField: TextFieldView = {
       var textfieldView = TextFieldView()
        textfieldView.titleLabel.text = "PASSWORD".localized()
        textfieldView.textfield.placeholder = "YOUR_PASSWORD".localized()
        textfieldView.textfield.textContentType = .password
        textfieldView.textfield.isSecureTextEntry = true
        textfieldView.textfield.imageView.image = UIImage(named: "Password")
        textfieldView.textfield.autocapitalizationType = .none
        return textfieldView
    }()
    
    var repeatPasswordTextField: TextFieldView = {
       var textfieldView = TextFieldView()
        textfieldView.titleLabel.text = "REPEAT_PASSWORD".localized()
        textfieldView.textfield.placeholder = "YOUR_PASSWORD".localized()
        textfieldView.textfield.textContentType = .password
        textfieldView.textfield.isSecureTextEntry = true
        textfieldView.textfield.imageView.image = UIImage(named: "Password")
        textfieldView.textfield.autocapitalizationType = .none
        return textfieldView
    }()
    
    var saveButton: UIButton = {
       var button = UIButton()
        button.setTitle("SAVE_CHANGES".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "7E2DFC button")
        button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }

}
extension ChangePasswordViewController {
    
    @objc func saveChanges() {
        let password = passwordTextField.textfield.text!
        
        SVProgressHUD.show()
        
        let parameters = ["password": password]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]

        AF.request(Urls.CHANGE_PASSWORD_URL, method: .put, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseData { response in

            SVProgressHUD.dismiss()
            
            var resultString = ""
            
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200{
                let json = JSON(response.data!)
                print("JSON: \(json)")

                if let token = json["accessToken"].string{
                    Storage.sharedInstance.accessToken = token
                    self.startApp()
//                    UserDefaults.standard.set(token, forKey: "accessToken")
//                    UserDefaults.standard.set(password, forKey: "password")
                    
                }else{
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            }else{
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode{
                    ErrorString = ErrorString + "\(sCode)"
                }
                ErrorString = ErrorString + "\(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        navigationItem.title = "CHANGE_PASSWORD".localized()
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(saveButton)
    }
    
    func setupConstraints() {
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(adaptiveSize(for: 21))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(adaptiveSize(for: -21))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(adaptiveSize(for: 8))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(adaptiveHeight(for: 56))
        }
    }
}
