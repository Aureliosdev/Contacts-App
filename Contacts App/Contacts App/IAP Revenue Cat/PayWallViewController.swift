//
//  PayWallViewController.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 07.03.2023.
//

import UIKit
import RevenueCat


class PayWallViewController: UIViewController {

    
    //BackgroundImage
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "gradient")
        return image
    }()
    
    
    
    //Header Label
    
    private let premiumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Premium"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .systemYellow
        label.font = UIFont(name: "palatino-bold", size: 60)
        return label
    }()
    
    private let premiumLabelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Upgrade to premium and get a lot of features.."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont(name: "palatino", size: 20)
        return label
    }()
    //Pricing and product info
    
    //CTA Buttons
    private let stackForButtons: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    
    private let subscribeButton: UIButton = {

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 400, height: 60))

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Subscribe", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.configuration = .plain()
        
        button.tintColor = .white

        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.systemBlue.cgColor]
            
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
    
        

        DispatchQueue.main.async {
        
            gradientLayer.frame = button.bounds
            
           
            button.layer.insertSublayer(gradientLayer, at: 0)
            
        
      
        }

        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 400, height: 60))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restore", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.configuration = .plain()
   
        button.tintColor = .white

        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemPurple.cgColor]
            
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
    
        

        DispatchQueue.main.async {
        
            gradientLayer.frame = button.bounds
            
           
            button.layer.insertSublayer(gradientLayer, at: 0)
            
        
      
        }
        return button
    }()
    //Terms of service
    private let termsView: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.textAlignment = .center
        text.textColor = .lightGray
        text.font = .systemFont(ofSize: 12)
        text.text = "This is auto-renewable Subscription. It will be changed to your iTunes account before each pay period. You can cancel anytime by going into your Settings > Subscriptions. Restore purchases if previously subscribed. "

        return text
        
    }()
    

    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
      
        label.tintColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        let myText = "3.99$\n1.99$"
        label.font = UIFont(name: "palatino", size: 60)
        label.text = myText
        
        let myAttributeString = NSMutableAttributedString(string: myText)
        myAttributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, myText.count-5))
        myAttributeString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.white, range: NSMakeRange(0, myText.count))

        let labelRange = NSRange(location: 0, length: myAttributeString.length)
        let labelFont = UIFont(name: "palatino-bold", size: 30)
        myAttributeString.addAttribute(NSAttributedString.Key.font, value: labelFont ?? UIFont.systemFont(ofSize: 30), range: labelRange)

        let strokeEffect = [NSAttributedString.Key.strokeWidth: -2.0, NSAttributedString.Key.strokeColor: UIColor.black] as [NSAttributedString.Key : Any]
        myAttributeString.addAttributes(strokeEffect, range: labelRange)

        label.attributedText = myAttributeString
        return label
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImage)
        view.addSubview(premiumLabel)
        view.addSubview(premiumLabelDescription)
        view.addSubview(stackForButtons)
        stackForButtons.addArrangedSubview(subscribeButton)
        stackForButtons.addArrangedSubview(restoreButton)
        view.addSubview(priceLabel)
        view.addSubview(termsView)
        setupCloseButton()
        setupButtons()

   
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
       
        
        NSLayoutConstraint.activate([
            backgroundImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.superview!.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor),
            
            
            premiumLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            premiumLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            premiumLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 120),

        
            premiumLabelDescription.topAnchor.constraint(equalTo: premiumLabel.bottomAnchor,constant: 20),
            premiumLabelDescription.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 40),
            premiumLabelDescription.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -40),
            
            priceLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 30),
            priceLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -30),
            priceLabel.topAnchor.constraint(equalTo: premiumLabelDescription.bottomAnchor,constant: 20),
            
            stackForButtons.bottomAnchor.constraint(equalTo: termsView.topAnchor,constant: -20),
            stackForButtons.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            stackForButtons.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            stackForButtons.heightAnchor.constraint(equalToConstant: 100),
            
            
    
            termsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 20),
            termsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -20),
            termsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    func setupCloseButton() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapClose))
        closeButton.tintColor = .white
        navigationItem.rightBarButtonItem = closeButton
    }

    @objc private func didTapClose() {
        dismiss(animated: true,completion: nil)
    }
    
    func setupButtons() {
        subscribeButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }

    @objc private func didTapRestore() {
        //Revenue cat
    }
    @objc private func didTapSubscribe() {
        IAPManager.shared.fetchPackages { package in
            guard let package = package else {
                return
            }
            print("Got packages")
            IAPManager.shared.subscribe(package: package) { success in
            
            }
        }
    }
    
    func  gradientEffectToButtons() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = subscribeButton.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let overlayLayer = CALayer()
        overlayLayer.frame = subscribeButton.bounds
        overlayLayer.backgroundColor = UIColor.clear.cgColor
        overlayLayer.addSublayer(gradientLayer)
        subscribeButton.layer.insertSublayer(overlayLayer, at: 0)

      
        subscribeButton.backgroundColor = .clear
        subscribeButton.setTitleColor(.white, for: .normal)
        
    }
}
