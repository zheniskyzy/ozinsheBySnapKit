//
//  ProfileViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 10.02.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let navigationBar = UINavigationBar()
//    let viewUnderNavigationBar = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationBar)
//        view.addSubview(viewUnderNavigationBar)
        configure()
        constraints()
        
    }
    
    func configure(){
        
        //colors
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        navigationBar.backgroundColor = UIColor(named: "navBar")
//        viewUnderNavigationBar =
    }
    
    func constraints(){
       
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(108)
        }
//        viewUnderNavigationBar.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.top.equalTo(navigationBar.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//
//        }
       
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
