//
//  TextFieldView.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 15.02.2024.
//

import Foundation
import UIKit
import SnapKit

class TextFieldView: UIView {
    
var error: String? {
        didSet {
            errorLabel.text = error
            aboutError()
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "111827-White(view, font etc)")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        return label
    }()
    
    var textfield: TextField = {
        let textField = TextField()
                
        return textField
    }()
    
    var errorLabel: UILabel = {
       let errorLabel = UILabel()
        errorLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        errorLabel.textColor = UIColor(named: "FF402B (error)")
        return errorLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextFieldView {
    func setupView() {
        addSubview(titleLabel)
        addSubview(textfield)
        addSubview(errorLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        textfield.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(adaptiveSize(for: -8))
            make.horizontalEdges.equalToSuperview()
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    func aboutError() {
        if error == nil {
            layer.borderColor = UIColor(named: "E5EBF0-374151 borderTF")?.cgColor
            errorLabel.snp.remakeConstraints { make in
                make.top.equalTo(textfield.snp.bottom)
                make.bottom.equalToSuperview()
            }
        }else{
            layer.borderColor = UIColor(named: "FF402B (error)")?.cgColor
            errorLabel.snp.remakeConstraints { make in
                make.top.equalTo(textfield.snp.bottom).inset(adaptiveSize(for: -16))
                make.bottom.equalToSuperview()
            }
        }
    }
}
