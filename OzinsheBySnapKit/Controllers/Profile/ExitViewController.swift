//
//  ExitViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 28.02.2024.
//

import UIKit

class ExitViewController: UIViewController, UIGestureRecognizerDelegate {
    var viewTranslation = CGPoint(x: 0, y: 0)
    
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
    
    var subtitleLabel: UILabel = {
        var label = UILabel()
        label.text = "EXIST_SUBTITLE".localized()
        label.font =  UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    var yesButton: UIButton = {
       var button = UIButton()
        button.setTitle("YES".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "7E2DFC button")
        button.addTarget(self, action: #selector(logoutYes), for: .touchUpInside)
        return button
    }()  
    
    var noButton: UIButton = {
       var button = UIButton()
        button.setTitle("NO".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.layer.cornerRadius = 12
        button.backgroundColor = .clear
        button.setTitleColor(UIColor(named: "5415C6-B376F7"), for: .normal)
        button.addTarget(self, action: #selector(cancelNoButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    @objc func handleDismiss(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1,options: .curveEaseOut, animations: {
                self.backgroundView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 100{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.backgroundView.transform = .identity
                })
            }else{
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
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
    @objc func logoutYes() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = CustomNavigationController(rootViewController: OnboardingViewController())
//        appDelegate.window?.makeKeyAndVisible()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first else {
           return
         }
        let rootViewController = CustomNavigationController(rootViewController: OnboardingViewController())
         window.rootViewController = rootViewController
    }
    
    @objc func cancelNoButton() {
        dismissView()
    }
}
extension ExitViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "50-30%")
        view.addSubview(backgroundView)
        backgroundView.addSubview(shortView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(subtitleLabel)
        backgroundView.addSubview(yesButton)
        backgroundView.addSubview(noButton)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    func setupConstraints(){
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
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(adaptiveSize(for: -8))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
        }
        yesButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).inset(adaptiveSize(for: -32))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(adaptiveHeight(for: 56))
        }
        noButton.snp.makeConstraints { make in
            make.top.equalTo(yesButton.snp.bottom).inset(adaptiveSize(for: -8))
            make.horizontalEdges.equalToSuperview().inset(adaptiveSize(for: 24))
            make.height.equalTo(adaptiveHeight(for: 56))
        }
    }
}
