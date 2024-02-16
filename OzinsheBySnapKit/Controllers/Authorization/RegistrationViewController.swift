//
//  RegistrationViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 14.02.2024.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class RegistrationViewController: UIViewController {
    
    let registLabel: UILabel = {
        let registLabel = UILabel()
        registLabel.text = "REGISTRATION".localized()
        registLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        registLabel.textColor = UIColor(named: "111827-White(view, font etc)")
        return registLabel
    }()

    let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "FILL_IN_THE_DATA".localized()
        subTitleLabel.textColor = UIColor(named: "6B7280-9CA3AF subtitle grey")
        subTitleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16.0)
        return subTitleLabel
    }()
    
    let stackViewForTextfield: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    let emailTextFieldView: TextFieldView = {
        let emailTextFieldView = TextFieldView()
        emailTextFieldView.titleLabel.text = "Email"
        emailTextFieldView.textfield.placeholder = "YOUR_EMAIL".localized()
        emailTextFieldView.textfield.keyboardType = .emailAddress
        emailTextFieldView.textfield.imageView.image = UIImage(named: "Message")
        emailTextFieldView.textfield.autocapitalizationType = .none
        return emailTextFieldView
    }()
    
    let passwordTextFieldView: TextFieldView = {
        let passwordTextFieldView = TextFieldView()
        passwordTextFieldView.titleLabel.text = "PASSWORD".localized()
        passwordTextFieldView.textfield.placeholder = "YOUR_PASSWORD".localized()
        passwordTextFieldView.textfield.textContentType = .password
        passwordTextFieldView.textfield.isSecureTextEntry = true
        passwordTextFieldView.textfield.imageView.image = UIImage(named: "Password")
        passwordTextFieldView.textfield.autocapitalizationType = .none
        return passwordTextFieldView
    }()
    
    let repeatPasswordTextFieldView: TextFieldView = {
        let repeatPasswordTextFieldView = TextFieldView()
        repeatPasswordTextFieldView.titleLabel.text = "REPEAT_PASSWORD".localized()
        repeatPasswordTextFieldView.textfield.placeholder = "YOUR_PASSWORD".localized()
        repeatPasswordTextFieldView.textfield.textContentType = .password
        repeatPasswordTextFieldView.textfield.isSecureTextEntry = true
        repeatPasswordTextFieldView.textfield.imageView.image = UIImage(named: "Password")
        repeatPasswordTextFieldView.textfield.autocapitalizationType = .none
        return repeatPasswordTextFieldView
    }()
    var stackViewWithError: UIStackView = {
        var stackView = UIStackView()
        stackView.spacing = 40
        stackView.axis = .vertical
        return stackView
    }()
    
lazy var button: UIButton = {
      let button = UIButton()
      button.setTitle("REGISTRATION".localized(), for: .normal)
      button.layer.cornerRadius = 12.0
      button.layer.borderWidth = 1.0
      button.backgroundColor = UIColor(named: "7E2DFC button")
      button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
      button.snp.makeConstraints { $0.height.equalTo(56) }
      button.addTarget(self, action: #selector(registration), for: .touchUpInside)
      return button
  }()
    var errorLabel: UILabel = {
       var errorLabel = UILabel()
        errorLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        errorLabel.text = "Мұндай email-ы бар пайдаланушы тіркелген"
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor(named: "FF402B (error)")
        errorLabel.isHidden = true
       return errorLabel
    }()
    
    var stackViewHorizontal: UIStackView = {
        var stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 6
        return stackview
    }()
    
    let accountExistsLabel: UILabel = {
        let accountExistsLabel = UILabel()
        accountExistsLabel.text = "DONT_HAVE_AN_ACCAOUNT?".localized()
        accountExistsLabel.textColor = UIColor(named: "6B7280-white")
        accountExistsLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        accountExistsLabel.textAlignment = .right
        return accountExistsLabel
    }()
    lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.setTitle("SIGN_IN".localized(), for: .normal)
        signInButton.setTitleColor(UIColor(named: "B376F7 (currentPageC)"), for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        signInButton.contentHorizontalAlignment = .left
        signInButton.addAction(UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchDown)
        return signInButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        view.addSubview(registLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(stackViewForTextfield)
        stackViewForTextfield.addArrangedSubview(emailTextFieldView)
        stackViewForTextfield.addArrangedSubview(passwordTextFieldView)
        stackViewForTextfield.addArrangedSubview(repeatPasswordTextFieldView)
        view.addSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(accountExistsLabel)
        stackViewHorizontal.addArrangedSubview(signInButton)
        view.addSubview(stackViewWithError)
        stackViewWithError.addArrangedSubview(errorLabel)
        stackViewWithError.addArrangedSubview(button)
        
        setupConstraints()

    }
    
}
extension RegistrationViewController {
    @objc func registration() {
        let email = emailTextFieldView.textfield.text!
        let password = passwordTextFieldView.textfield.text!
        
        if email.isEmpty || !ReusableFuncs().isValidEmail(email) {
             emailTextFieldView.error = "INVALID_FORMAT".localized()
        }else{
            emailTextFieldView.error = nil
        }
        
        SVProgressHUD.show()
        let parameters = ["email": email, "password": password]
        AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            let json = JSON(response.data!)
            print("JSON: \(json)")
            if response.response?.statusCode == 200{
                
                if let token = json["accessToken"].string{
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    ReusableFuncs().startApp(self)
                }else{
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            }else{
                var ErrorString = "CONNECTION_ERROR".localized()
                if let sCode = response.response?.statusCode{
                    ErrorString = ErrorString + "\(sCode)"
                }
              
                if let errorMessage = json["message"].string {
                  if  errorMessage == "Error: Email is already in use!"{
                      self.errorLabel.isHidden = false
                      
                  }else{
                      self.errorLabel.isHidden = true
                  }
                }else{
//                    ErrorString = ErrorString + "\(resultString)"
//                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
                }
                
            }
        }
    }
    
   
    
    func setupConstraints(){
        registLabel.snp.makeConstraints { make in
           make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
       }
       subTitleLabel.snp.makeConstraints { make in
           make.top.equalTo(registLabel.snp.bottom).inset(-10)
           make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
       }
        stackViewForTextfield.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).inset(-32)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        stackViewWithError.snp.makeConstraints { make in
            make.top.equalTo(stackViewForTextfield.snp.bottom).inset(-32)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        stackViewHorizontal.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).inset(-24)
            make.centerX.equalToSuperview()
        }
        
    }
}

