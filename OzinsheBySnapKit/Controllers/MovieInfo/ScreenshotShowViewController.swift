//
//  ScreenshotShowViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 25.02.2024.
//

import UIKit

class ScreenshotShowViewController: UIViewController {
    var imageview = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        view.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        imageview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
