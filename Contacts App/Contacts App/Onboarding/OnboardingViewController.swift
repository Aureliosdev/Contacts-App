//
//  OnboardingViewController.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    var pages: [OnboardingModel] = [] {
        didSet {
            
            pageControl.numberOfPages = pages.count
     
             collectionView.reloadData()
            
    
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(OnboardingCollectionViewCell.self ,forCellWithReuseIdentifier: OnboardingCollectionViewCell.idenfifier)
    
        
        layout.scrollDirection = .horizontal
        
        
        return collection
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "palatino", size: 20)
        button.setTitle("Skip", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemIndigo
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 30)
       
        button.layer.masksToBounds = true
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "palatino", size: 20)
        button.backgroundColor = .systemIndigo
  
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 50)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.currentPageIndicatorTintColor = .systemIndigo
        page.pageIndicatorTintColor = .lightGray
       
        page.numberOfPages = 3
        return page
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        activateConstraints()
        generatePages()
        skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        pageControl.addTarget(self, action: #selector(didTapChangeValue), for: .valueChanged)
    }
    
    func generatePages() {
        pages = [
            OnboardingModel(imageName: "1", title: "Play Anywhere", subtitle: "The video call feature can be accessed from anywhere in your house to help you."),
                 
            OnboardingModel(imageName: "2", title: "Stay healthy", subtitle: "Nobody likes to be alone and the built-in group video call feature helps you connect."),
                 
            OnboardingModel(imageName:"3", title: "Make Connections", subtitle: "While working the app reminds you to smile, laugh, walk and talk with those who matters.")
               
        ]
        
    }


    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        skipButton.layer.cornerRadius = skipButton.frame.height / 2
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
    }


    func activateConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            skipButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: -20),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -105),
            skipButton.heightAnchor.constraint(equalToConstant: 44),
            
            
            
            nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: 25),
          
            nextButton.widthAnchor.constraint(equalTo: skipButton.widthAnchor,multiplier: 1.2),
            nextButton.heightAnchor.constraint(equalToConstant: 54),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -100),
            
            
            pageControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 0),
            pageControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: 0),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor,constant: -32),
        ])
    }
    
    @objc private func didTapNext() {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            start()
        } else {
            pageControl.currentPage += 1

            let x = CGFloat(pageControl.currentPage) * collectionView.frame.width
            collectionView.setContentOffset(CGPoint(x: x, y: -96.7), animated: true)
       
            handlePageChanges()
        }
    }
    
    @objc private  func didTapSkip() {
        start()
    }
    
    func start() {
        UserDefaults.standard.set(true, forKey: "UserDidSeeOnboarding")
        let vc = UINavigationController(rootViewController: ContactsViewController())
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    func handlePageChanges() {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            skipButton.isHidden = true
            nextButton.setTitle("Start", for: .normal)

        }else {
            skipButton.isHidden = false
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @objc func didTapChangeValue() {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            skipButton.isHidden = true
            nextButton.setTitle("Start", for: .normal)
            let x = CGFloat(pageControl.currentPage) * collectionView.frame.width
            collectionView.setContentOffset(CGPoint(x: x, y: -96.7), animated: true)
       
        }else {
            skipButton.isHidden = false
            nextButton.setTitle("Next", for: .normal)
            let x = CGFloat(pageControl.currentPage) * collectionView.frame.width
            collectionView.setContentOffset(CGPoint(x: x, y: -96.7), animated: true)
       
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.idenfifier, for: indexPath) as! OnboardingCollectionViewCell

        let onboardingModel = pages[indexPath.item]
        cell.setup(onboardingModel: onboardingModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
 
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    

        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        handlePageChanges()
    }
}
