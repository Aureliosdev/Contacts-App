//
//  ContactsTableViewCell.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    static let identifier: String = "ContactTableViewCell"
    
     let contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font  = UIFont(name: "palatino-italic-bold", size: 20)
        label.tintColor = .label
        label.textAlignment = .natural
        
        return label
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(contactLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            contactLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            contactLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: 10),
            contactLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 10),
            contactLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10)
        
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        contactLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
