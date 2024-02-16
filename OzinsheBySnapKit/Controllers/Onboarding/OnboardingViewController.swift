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

    lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = view.bounds.size
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "Cell")
        
        return collectionView
        }()

    lazy var skipButton: UIButton = {
        let skipButton = UIButton()
    
        skipButton.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        skipButton.setTitle("SKIP".localized(), for: .normal)
        skipButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        skipButton.setTitleColor(UIColor(named: "111827-White(view, font etc)"), for: .normal)
        skipButton.layer.cornerRadius = 8.0
        skipButton.contentEdgeInsets.right = 16.0
        skipButton.contentEdgeInsets.left = 16.0
        skipButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchDown)
        return skipButton
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "7E2DFC button")
        button.setTitle("NEXT".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(nextButtonTouched), for: .touchDown)
        
        return button
    }()
    
   lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = true
        pageControl.pageIndicatorTintColor = UIColor(named: "D1D5DB-4B5563(pageControl)")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "B376F7 (currentPageC)")
        pageControl.numberOfPages = OnboardingItems.count
        pageControl.currentPage = 0
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
        view.addSubview(collectionView)
        view.addSubview(skipButton)
        view.addSubview(button)
        view.addSubview(pageControl)
        setupConstraints()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupConstraints(){
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(118)
            make.horizontalEdges.equalToSuperview()
           
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).inset(-24)
            make.height.equalTo(56)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Collectionview
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnboardingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OnboardingCell
        
        cell.setData(image: OnboardingItems[indexPath.row].image, title: OnboardingItems[indexPath.row].title, subtitle: OnboardingItems[indexPath.row].subtitle)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            button.isHidden = false
            skipButton.isHidden = true
        } else {
            button.isHidden = true
            skipButton.isHidden = false
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let offSet = scrollView.contentOffset.x
      let width = scrollView.frame.width
      let currentIndex = Int(round(offSet/width))
      
       pageControl.currentPage = currentIndex
    }
    
    @objc func nextButtonTouched(){
        let signinVC = SignInViewController()
        navigationController?.pushViewController(signinVC, animated: true)
    }
}
