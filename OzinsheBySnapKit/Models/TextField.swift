//
//  TextField.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 15.02.2024.
//

import Foundation
import UIKit
import SnapKit

class TextField: UITextField {
    
    
    override var placeholder: String? {
        didSet{
            guard let placeholder else {
                            return
                        }
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(named: "6B7280-9CA3AF subtitle grey") ?? .black, .font: UIFont(name: "SFProDisplay-Regular", size: 16)!])
            
        }
    }
    
    override var isSecureTextEntry: Bool {
        didSet{
            showButton.isHidden = false
        }
    }
    // MARK: - imageview
    
    var imageView: UIImageView = {
        var imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
    
        return imageview
    }()
    
    // MARK: - button
    
   lazy var showButton: UIButton = {
        var showButton = UIButton()
        showButton.isHidden = true
        showButton.setImage(UIImage(named: "Show"), for: .normal)
        showButton.addAction(UIAction(handler: { _ in
            self.isSecureTextEntry.toggle()
        }), for: .touchDown)
       
        return showButton
    }()
    // MARK: - padding
    var padding = UIEdgeInsets(top: 16, left: 44, bottom: 16, right: 52);
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    // MARK: - func
    
    @objc func didBegin(){
        layer.borderColor = UIColor(named: "9753F0 (border)")?.cgColor
    }
    @objc func didEnd(){
        layer.borderColor = UIColor(named: "E5EBF0-374151 borderTF")?.cgColor
    }
}

extension TextField {
    func setupView(){
        borderStyle = .none
        layer.cornerRadius = 12.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(named: "E5EBF0-374151 borderTF")?.cgColor
        font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textColor = UIColor(named: "111827-White(view, font etc)")
        backgroundColor = UIColor(named: "white-1C2431")
        
       addSubview(imageView)
       addSubview(showButton)
        
        addTarget(self, action: #selector(didBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(didEnd), for: .editingDidEnd)
    }
    func setupConstraints(){
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(adaptiveSize(for: 20))
            make.left.equalToSuperview().inset(adaptiveSize(for: 16))
        }
        showButton.snp.makeConstraints { make in
            make.width.equalTo(adaptiveSize(for: 52))
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}



