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

class SignInViewController: UIViewController {

    let helloLabel = UILabel()
    let subTitleLabel = UILabel()
    let emailLabel = UILabel()
    let emailTextField = TextFieldWithPadding()
    let messageImageForEmail = UIImageView()
    let passwordLabel = UILabel()
    let passwordTextField = TextFieldWithPadding()
    let passwordImage = UIImageView()
    let showButton = UIButton()
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(helloLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(messageImageForEmail)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordImage)
        view.addSubview(button)
        view.addSubview(showButton)
        
        configure()
        constraints()
        button.addTarget(self, action: #selector(buttonSignIn), for: .touchUpInside)
        
    }

    @objc func buttonSignIn(){
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        // что бы нельзя было нажать на кнопку войти без ввода логина и пароля
        if email.isEmpty || password.isEmpty{
            return
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
                    self.startApp()
                    
                }else{
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                }
            }
        }
    }
    func startApp(){
        let tabBarVC = TabBarController()
//        navigationController?.show(tabBarVC, sender: self)
            tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }
    
    func configure(){
        helloLabel.text = "HELLO"
        subTitleLabel.text = "Аккаунтқа кіріңіз"
        emailLabel.text = "Email"
        passwordLabel.text = "Құпия сөз"
        button.setTitle("Кіру", for: .normal)
        
     
        emailTextField.borderStyle = .none
        emailTextField.placeholder = "Email"
        emailTextField.layer.cornerRadius = 12.0
        emailTextField.layer.borderWidth = 1.0
        
        passwordTextField.borderStyle = .none
        passwordTextField.placeholder = "Password".localized()
        passwordTextField.layer.cornerRadius = 12.0
        passwordTextField.layer.borderWidth = 1.0
        

        button.layer.cornerRadius = 12.0
        button.layer.borderWidth = 1.0
        
        showButton.setImage(UIImage(named: "Show"), for: .normal)
        
        
        messageImageForEmail.contentMode = .scaleAspectFill
        messageImageForEmail.image = UIImage(named: "Message")
        
        passwordImage.contentMode = .scaleAspectFill
        passwordImage.image = UIImage(named: "Password")
        
        // colors
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        emailLabel.textColor = UIColor(named: "111827-White(view, font etc)")
        subTitleLabel.textColor = UIColor(named: "6B7280-9CA3AF subtitle grey")
        passwordLabel.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        emailTextField.layer.borderColor = UIColor(named: "E5EBF0-374151 borderTF")?.cgColor
        passwordTextField.layer.borderColor = UIColor(named: "E5EBF0-374151 borderTF")?.cgColor
        button.backgroundColor = UIColor(named: "7E2DFC button")
        
        // font
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        subTitleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16.0)
        helloLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        emailLabel.font = UIFont(name: "SFProDisplay-Bold", size: 14)
    }
    
    func constraints(){
        
        helloLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).inset(-29)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
        }
        messageImageForEmail.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(emailTextField)
            make.left.equalTo(emailTextField.snp.left).inset(16)
            
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(-13)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
        }
        passwordImage.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalTo(passwordTextField)
            make.left.equalTo(passwordTextField.snp.left).inset(16)
        }
        showButton.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.trailing.equalTo(passwordTextField)
            make.centerY.equalTo(passwordTextField)
        }
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
            make.top.equalTo(passwordTextField.snp.bottom).inset(-79)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
