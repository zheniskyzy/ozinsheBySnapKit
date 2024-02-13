//
//  OnboardingViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 12.02.2024.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var OnboardingItems: [OnboardingItem] = [
    OnboardingItem(title: "ÖZINŞE-ге қош келдің!", subtitle: "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары", image: UIImage(named: "firstSlide")!),
    OnboardingItem(title: "ÖZINŞE-ге қош келдің!", subtitle: "Кез келген құрылғыдан қара\nСүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара", image: UIImage(named: "secondSlide")!),
    OnboardingItem(title: "ÖZINŞE-ге қош келдің!", subtitle: "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз", image: UIImage(named: "thirdSlide")!)
    ]

    private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
       layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
       collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        
        
       collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "Cell")
        
        return collectionView
        }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupConstraints()
        

    }
 
    func setupConstraints(){
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    // MARK: - Collectionview
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnboardingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OnboardingCell

        cell.setData(image: OnboardingItems[indexPath.row].image, title1: OnboardingItems[indexPath.row].title, subtitle1: OnboardingItems[indexPath.row].subtitle)
        
        // ячейки были друг под другом, добавила это что бы они были как страницы
        cell.frame = collectionView.bounds
        
        return cell
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
