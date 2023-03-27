//
//  OnboardingCollectionViewCell.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 07.03.2023.
//

import UIKit


class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    
    static let idenfifier: String = "OnboardingCollectionViewCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 32
        
        return stackView
        
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        return image
        
        
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont(name: "palatino-bold", size: 28)
        
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont(name: "palatino", size: 17)
        
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(descriptionLabel)
        setupConstraints()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func setup(onboardingModel: OnboardingModel) {
        imageView.image = UIImage(named: onboardingModel.imageName)
        firstLabel.text = onboardingModel.title
        descriptionLabel.text = onboardingModel.subtitle
    }
  
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: -96.7),

            
        
        ])
    
    }
}

class PlaceholderImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        if let placeholderImage = image {
            return placeholderImage.size
        } else {
            return super.intrinsicContentSize
        }
    }
}
