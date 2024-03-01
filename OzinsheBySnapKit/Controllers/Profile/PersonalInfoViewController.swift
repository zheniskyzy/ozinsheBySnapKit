//
//  PersonalInfoViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 26.02.2024.
//

import UIKit
import Localize_Swift
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PersonalInfoViewController: UIViewController {

//    MARK: - UI Name
    var yourNameLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR_NAME".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    var nameTextfield: UITextField = {
        var textfield = UITextField()
        textfield.borderStyle = .none
        textfield.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return textfield
    }()
    var viewUnderNameTextfield: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }()   
//    MARK: - UI Email
    var yourEmail: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    var emailTextfield: UITextField = {
        var textfield = UITextField()
        textfield.borderStyle = .none
        textfield.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return textfield
    }()
    var viewUnderEmailTextfield: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }() 
//    MARK: - UI Number
    
    var yourNumber: UILabel = {
        let label = UILabel()
        label.text = "NUMBER".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    var numberTextfield: UITextField = {
        var textfield = UITextField()
        textfield.borderStyle = .none
        textfield.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return textfield
    }()
    var viewUnderNumberTextfield: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }()
    
//    MARK: - UI BirthDate
    
    var yourBirthdate: UILabel = {
        let label = UILabel()
        label.text = "BIRTH_DATE".localized()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    var birthdateTextfield: UITextField = {
        var textfield = UITextField()
        textfield.borderStyle = .none
        textfield.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return textfield
    }()
    var viewUnderBirthdateTextfield: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB-1C2431")
        return view
    }()
    
    var ChangeButton: UIButton = {
       var button = UIButton()
        button.setTitle("SAVE_CHANGES".localized(), for: .normal)
        button.backgroundColor = UIColor(named: "7E2DFC button")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveInfo), for: .touchUpInside)
        return button
    }()
    
    lazy var datePiker: UIDatePicker = {
         let datePiker = UIDatePicker()
         datePiker.datePickerMode = .date
         datePiker.locale = .autoupdatingCurrent
         datePiker.preferredDatePickerStyle = .wheels
         datePiker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
         return datePiker
     }()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        getInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension PersonalInfoViewController {
    
    @objc func datePickerChanged(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        self.birthdateTextfield.text = dateFormatter.string(from: datePiker.date)
    }

    @objc func doneButtonAction(){
        birthdateTextfield.resignFirstResponder()
    }
    
    @objc func saveInfo() {
        
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
         let birthdate = dateFormatter.string(from: datePiker.date)
         
         let phoneNumber = numberTextfield.text ?? ""
         let name = nameTextfield.text ?? ""
         
         
         let parameters = ["name": name, "phoneNumber": phoneNumber, "birthDate": birthdate]
         let headers: HTTPHeaders = [
             "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
         ]
         
         AF.request(Urls.PROFILE_UPDATE_URL, method: .put, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
             var resultString = ""
             if let data = response.data{
                 resultString = String(data: data, encoding: .utf8)!
                 print(resultString)
             }
             if response.response?.statusCode == 200{
                 let json = JSON(response.data!)
                 print("JSON: \(json)")
                 
                 self.nameTextfield.text = json["name"].string
                 self.emailTextfield.text = json["user"]["email"].string
                 self.numberTextfield.text = json["phoneNumber"].string
                 
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
    
    func getInfo() {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.PROFILE_GET_URL, method: .get, encoding: JSONEncoding.default, headers: headers).responseData { response in
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200{
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let birthDate = json["birthDate"].string {
                   let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    if let date = dateFormatter.date(from: birthDate){
                        self.datePiker.date = date
                        dateFormatter.dateFormat = "dd MMM yyyy"
                        self.birthdateTextfield.text = dateFormatter.string(from: date)
                    }
                }
                self.nameTextfield.text = json["name"].string
                self.emailTextfield.text = json["user"]["email"].string
                self.numberTextfield.text = json["phoneNumber"].string
                
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
    
    func setupView() {
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        navigationItem.title = "PERSONAL_INFO".localized()
        view.addSubview(yourNameLabel)
        view.addSubview(nameTextfield)
        view.addSubview(viewUnderNameTextfield)
        view.addSubview(yourEmail)
        view.addSubview(emailTextfield)
        view.addSubview(viewUnderEmailTextfield)
        view.addSubview(yourNumber)
        view.addSubview(numberTextfield)
        view.addSubview(viewUnderNumberTextfield)
        view.addSubview(yourBirthdate)
        view.addSubview(birthdateTextfield)
        view.addSubview(viewUnderBirthdateTextfield)
        view.addSubview(ChangeButton)
        
        birthdateTextfield.inputView = datePiker
        
        //кнопка готово, его ширина равно ширине экрана
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
                // кнопка готово справа
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // сама кнопка
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        
        
        doneToolbar.items = [flexSpace, doneButton]
        
        //скрывать клаву или тулбар
        birthdateTextfield.inputAccessoryView = doneToolbar
    }
    
    func setupConstraints() {
        yourNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(adaptiveSize(for: 132))
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        nameTextfield.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(43)
            make.top.equalTo(yourNameLabel.snp.bottom)
        }
        viewUnderNameTextfield.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(nameTextfield.snp.bottom).inset(-2)
        }
        yourEmail.snp.makeConstraints { make in
            make.top.equalTo(viewUnderNameTextfield.snp.bottom).inset(adaptiveSize(for: -24))
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        emailTextfield.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(43)
            make.top.equalTo(yourEmail.snp.bottom)
        }
        viewUnderEmailTextfield.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(emailTextfield.snp.bottom).inset(-2)
        }
        yourNumber.snp.makeConstraints { make in
            make.top.equalTo(viewUnderEmailTextfield.snp.bottom).inset(adaptiveSize(for: -24))
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        numberTextfield.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(43)
            make.top.equalTo(yourNumber.snp.bottom)
        }
        viewUnderNumberTextfield.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(numberTextfield.snp.bottom).inset(-2)
        }
        yourBirthdate.snp.makeConstraints { make in
            make.top.equalTo(viewUnderNumberTextfield.snp.bottom).inset(adaptiveSize(for: -24))
            make.left.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        birthdateTextfield.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(43)
            make.top.equalTo(yourBirthdate.snp.bottom)
        }
        viewUnderBirthdateTextfield.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.top.equalTo(birthdateTextfield.snp.bottom).inset(-2)
        }
        ChangeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(adaptiveSize(for: 56))
        }
    }
}
