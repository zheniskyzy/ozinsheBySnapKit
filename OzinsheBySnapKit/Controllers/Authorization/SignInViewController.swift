//
//  SignInViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 10.02.2024.
//
import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import Localize_Swift

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    let helloLabel: UILabel = {
        let helloLabel = UILabel()
        helloLabel.text = "HELLO".localized()
        helloLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        helloLabel.textColor = UIColor(named: "111827-White(view, font etc)")
        return helloLabel
    }()
    
    let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "SIGN_INTO_YOUR_ACCOUNT".localized()
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
    
      let passwordForgotButton: UIButton = {
        let passwordForgotButton = UIButton()
        passwordForgotButton.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        passwordForgotButton.setTitle("FORGOT_PASSWORD?".localized(), for: .normal)
        passwordForgotButton.setTitleColor(UIColor(named: "B376F7 (currentPageC)"), for: .normal)
        passwordForgotButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        passwordForgotButton.contentHorizontalAlignment = .right
        return passwordForgotButton
      }()

     lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN_IN".localized(), for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor(named: "7E2DFC button")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.addTarget(self, action: #selector(buttonSignIn), for: .touchUpInside)
        return button
      }()

    var stackViewForLabelAndButton: UIStackView = {
       var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
      let accountExistsLabel: UILabel = {
        let accountExistsLabel = UILabel()
        accountExistsLabel.text = "DONT_HAVE_AN_ACCAOUNT?".localized()
        accountExistsLabel.textColor = UIColor(named: "6B7280-white")
        accountExistsLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        accountExistsLabel.textAlignment = .right
        return accountExistsLabel
      }()
    
      lazy var registrButton: UIButton = {
        let registrButton = UIButton()
        registrButton.setTitle("REGISTRATION".localized(), for: .normal)
        registrButton.setTitleColor(UIColor(named: "B376F7 (currentPageC)"), for: .normal)
        registrButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        registrButton.contentHorizontalAlignment = .left
        registrButton.addTarget(self, action: #selector(registation), for: .touchDown)
        return registrButton
      }()
    
      let orLabel: UILabel = {
        let orLabel = UILabel()
        orLabel.text = "OR".localized()
        orLabel.textColor = UIColor(named: "9CA3AF")
        orLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        orLabel.textAlignment = .center
        return orLabel
          
      }()
      let appleButton: UIButton = {
        let appleButton = UIButton()
        appleButton.setTitle("LOGIN_WITH_APPLE".localized(), for: .normal)
        appleButton.setTitleColor(UIColor(named: "111827-White(view, font etc)"), for: .normal)
        appleButton.backgroundColor = UIColor(named: "white-4B5563 (applebutton)")
        appleButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        appleButton.layer.cornerRadius = 12.0
        appleButton.layer.borderWidth = 1.5
        appleButton.layer.borderColor = UIColor(named: "E5E7EB-4B5563 (applebuttonCorner)")?.cgColor
        return appleButton
          
      }()
      let appleImage: UIImageView = {
        let appleImage = UIImageView()
        appleImage.image = UIImage(named: "AppleLogo")
        return appleImage
          
      }()
      let googleButton: UIButton = {
        let googleButton = UIButton()
        googleButton.setTitle("LOGIN_WITH_GOOGLE".localized(), for: .normal)
        googleButton.setTitleColor(UIColor(named: "111827-White(view, font etc)"), for: .normal)
        googleButton.backgroundColor = UIColor(named: "white-4B5563 (applebutton)")
        googleButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        googleButton.layer.cornerRadius = 12.0
        googleButton.layer.borderWidth = 1.5
        googleButton.layer.borderColor = UIColor(named: "E5E7EB-4B5563 (applebuttonCorner)")?.cgColor
        return googleButton
          
      }()
      let googleImage: UIImageView = {
        let googleImage = UIImageView()
        googleImage.image = UIImage(named: "GoogleLogo")
        return googleImage
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        view.addSubview(helloLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(stackViewForTextfield)
        stackViewForTextfield.addArrangedSubview(emailTextFieldView)
        stackViewForTextfield.addArrangedSubview(passwordTextFieldView)
        view.addSubview(passwordForgotButton)
        view.addSubview(button)
        view.addSubview(stackViewForLabelAndButton)
        stackViewForLabelAndButton.addArrangedSubview(accountExistsLabel)
        stackViewForLabelAndButton.addArrangedSubview(registrButton)
        view.addSubview(orLabel)
        view.addSubview(appleButton)
        view.addSubview(appleImage)
        view.addSubview(googleButton)
        view.addSubview(googleImage)
        setupConstraints()
    }
}

extension SignInViewController {
    @objc func buttonSignIn(){
        let email = emailTextFieldView.textfield.text!
        let password = passwordTextFieldView.textfield.text!
// хотела нижкий кусочек кода затолкать в ReusableFuncs  но так и не смогла додумать реализацию
//       ReusableFuncs().errorHandling(email: email)
        
        if email.isEmpty || !ReusableFuncs().isValidEmail(email) {
             emailTextFieldView.error = "INVALID_FORMAT".localized()
        }else{
            emailTextFieldView.error = nil
        }
        
        SVProgressHUD.show()
        
        let parameters = ["email": email, "password": password]
        
        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
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
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    UserDefaults.standard.set(email, forKey: "email")
                    ReusableFuncs().startApp(self)
                    
                }else{
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                }
            }
        }
    }
    
      @objc func registation(){
        let registrationVC = RegistrationViewController()
          navigationController?.pushViewController(registrationVC, animated: true)
      }
    func setupConstraints(){
        
        helloLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).inset(-10)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        stackViewForTextfield.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).inset(-32)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        passwordForgotButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(stackViewForTextfield.snp.bottom).inset(-17)
        }
        button.snp.makeConstraints { make in
              make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
              make.height.equalTo(56)
              make.top.equalTo(passwordForgotButton.snp.bottom).inset(-40)
            }
        stackViewForLabelAndButton.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).inset(-24)
            make.centerX.equalToSuperview()
        }
        orLabel.snp.makeConstraints { make in
              make.top.equalTo(stackViewForLabelAndButton.snp.bottom).inset(-40)
              make.horizontalEdges.equalToSuperview().inset(24)
            }
        appleButton.snp.makeConstraints { make in
             make.top.equalTo(orLabel.snp.bottom).inset(-16)
             make.horizontalEdges.equalToSuperview().inset(24)
             make.height.equalTo(52)
           }
           appleImage.snp.makeConstraints { make in
             make.height.width.equalTo(16)
             make.centerY.equalTo(appleButton)
             make.right.equalTo(appleButton.titleLabel!.snp.left).inset(-8)
           }
           googleButton.snp.makeConstraints { make in
             make.top.equalTo(appleButton.snp.bottom).inset(-8)
             make.horizontalEdges.equalToSuperview().inset(24)
             make.height.equalTo(52)
           }
           googleImage.snp.makeConstraints { make in
             make.height.width.equalTo(16)
             make.centerY.equalTo(googleButton)
             make.right.equalTo(googleButton.titleLabel!.snp.left).inset(-8)
           }
    }

}
