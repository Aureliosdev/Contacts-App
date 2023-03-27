//
//  DetailedViewController.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import UIKit
import CoreData

protocol ImagePickerDelegate: AnyObject {
    func imagePickerDidFinishPicking(imageData: Data?)
}


class DetailedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var contact: Contact!
    var contactManager = ContactManager()
    var timer: Timer?
    var countDown = 0
    var countDownTotal = 5
    weak var delegate: ImagePickerDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.trackTintColor = .gray
        progress.progressTintColor = .systemGreen
        progress.isHidden = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let secondaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainView: UIView = {
        let view = UIView()
//        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let labelView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let initialsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        
        label.text = "AB"
        label.textColor = .white
        return label
    }()
    
    private let imageContact: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isHidden = false
        image.clipsToBounds = true
        return image
    }()
    
    private let fullName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Abylay Baibolov"
        
        return label
    }()
    
    private let stackForButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment  = .fill
        stack.distribution = .fill
        stack.spacing = 16
        
        return stack
    }()
    
    private let stackCallMessageButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment  = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        return stack
        
    }()
    
    private let callStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment  = .fill
        stack.distribution = .fill
//        stack.spacing = 5
        stack.backgroundColor = .white
        stack.contentMode = .scaleToFill
        return stack
    }()
    
    private let messageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment  = .fill
        stack.distribution = .fill
//        stack.spacing = 5
        stack.backgroundColor = .white
        return stack
    }()
    
    private let faceTimeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment  = .fill
        stack.distribution = .fill
//        stack.spacing = 5
        stack.backgroundColor = .white
        return stack
    }()
    
    private let mailStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment  = .fill
        stack.distribution = .fill
//        stack.spacing = 5
        stack.backgroundColor = .white
        return stack
    }()
    
    private let callButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        button.tintColor = .systemBlue
       
        button.configuration = .plain()
        return button
        
    }()
    
    private let callButtonTitle: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("call", for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.numberOfLines = 1
        return button
        
    }()
    
    private let messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message.fill"), for: .normal)
        button.tintColor = .systemBlue
       
        button.configuration = .plain()
        return button
        
    }()
    
    private let messageButtonTitle: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("message", for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.numberOfLines = 1
    
        return button
        
    }()
    
    private let faceTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "video.fill"), for: .normal)
        button.tintColor = .systemBlue
       
        button.configuration = .plain()
        return button
        
    }()
    
    private let faceTimeButtonTitle: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("facetime", for: .normal)
        button.titleLabel?.numberOfLines = 1
        button.tintColor = .systemBlue

       
        return button
        
    }()
    
    private let mailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        button.tintColor = .systemGray2
       
        button.configuration = .plain()
        return button
        
    }()
    
    private let mailButtonTitle: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("mail", for: .normal)
        button.tintColor = .systemGray2
     
        return button
        
    }()
    
    private let phoneNumberInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .white
        stackView.spacing = 5
        return stackView
        
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.tintColor = .label
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        label.text = "Phone number"
        return label
        
    }()
    
    private let phoneNumberButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+77006936568", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete contact", for: .normal)
        button.tintColor = .systemRed
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .white
        return button
        
        
    }()
    
    private let undodeleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("undo delete contact", for: .normal)
        button.tintColor = .systemRed
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .white
        button.isHidden = true
        return button
    
    }()
    

    
    //MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setupUIElements()
        
        cornerRadiuses()
        setupConstraints()
        configureNavItems()
        setupContactContent()
        configureButtons()
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        undodeleteButton.addTarget(self, action: #selector(didTapUndo), for: .touchUpInside)

        configureGestureRecognizer()
            saveImageInUserDefaults()
     

            
    }
    
    public func saveImageInUserDefaults() {
        if let imageData = UserDefaults.standard.data(forKey: "contactImage") {
                imageContact.image = UIImage(data: imageData)
            }
    }
    
    func configureButtons() {
        callButton.addTarget(self, action: #selector(didTapCall), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(didTapMessage), for: .touchUpInside)
        faceTimeButton.addTarget(self, action: #selector(didTapFacetime), for: .touchUpInside)
        callButtonTitle.addTarget(self, action: #selector(didTapCall), for: .touchUpInside)
        messageButtonTitle.addTarget(self, action: #selector(didTapMessage), for: .touchUpInside)
        faceTimeButtonTitle.addTarget(self, action: #selector(didTapFacetime), for: .touchUpInside)
    }
    
    @objc private func didTapCall() {
        open(contactType: .call)
    }
    @objc private func didTapMessage() {
        open(contactType: .message)
    }
    @objc private func didTapFacetime() {
        open(contactType: .faceTime)
    }
    
    func configureNavItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationController?.navigationBar.tintColor = .label
    }
    
    func cornerRadiuses() {
        callStackView.layer.cornerRadius = 5
        messageStackView.layer.cornerRadius = 5
        faceTimeStackView.layer.cornerRadius = 5
        mailStackView.layer.cornerRadius = 5
        phoneNumberInfoStackView.layer.cornerRadius = 5
        deleteButton.layer.cornerRadius = 5
        undodeleteButton.layer.cornerRadius = 5
    }
    
    func setupUIElements() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(progressView)
        mainStackView.addArrangedSubview(secondaryStackView)
        secondaryStackView.addArrangedSubview(mainView)
        mainView.addSubview(labelView)
        labelView.addSubview(initialsLabel)
        labelView.addSubview(imageContact)
        secondaryStackView.addArrangedSubview(fullName)
        secondaryStackView.addArrangedSubview(stackForButtons)
        

        stackForButtons.addArrangedSubview(stackCallMessageButtons)
        stackCallMessageButtons.addArrangedSubview(callStackView)
        stackCallMessageButtons.addArrangedSubview(messageStackView)
        stackCallMessageButtons.addArrangedSubview(faceTimeStackView)
        stackCallMessageButtons.addArrangedSubview(mailStackView)
        callStackView.addArrangedSubview(callButton)
        callStackView.addArrangedSubview(callButtonTitle)
        messageStackView.addArrangedSubview(messageButton)
        messageStackView.addArrangedSubview(messageButtonTitle)
        faceTimeStackView.addArrangedSubview(faceTimeButton)
        faceTimeStackView.addArrangedSubview(faceTimeButtonTitle)
        mailStackView.addArrangedSubview(mailButton)
        mailStackView.addArrangedSubview(mailButtonTitle)
        phoneNumberInfoStackView.addArrangedSubview(phoneNumberLabel)
        phoneNumberInfoStackView.addArrangedSubview(phoneNumberButton)
        stackForButtons.addArrangedSubview(phoneNumberInfoStackView)
        secondaryStackView.addArrangedSubview(deleteButton)
        secondaryStackView.addArrangedSubview(undodeleteButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        labelView.layer.cornerRadius = labelView.frame.height / 2
        imageContact.layer.cornerRadius = imageContact.frame.size.width / 2
    }
  
    
    func setupConstraints() {
        let mainStackConsts = [
            mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -16),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
            
        ]
   
        
        let labelViewConsts = [
            labelView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1 / 4.5),
            labelView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1 / 4.5),
        labelView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        labelView.topAnchor.constraint(equalTo: mainView.topAnchor),
        labelView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
            ]
        

        let deleteAndUndoButtonConsts = [
        
            deleteButton.heightAnchor.constraint(equalToConstant: 45),
            undodeleteButton.heightAnchor.constraint(equalToConstant: 45)
        ]

        let initialsLabelConsts = [
        
            initialsLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor,constant: 16),
            initialsLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor,constant: -16),
            initialsLabel.topAnchor.constraint(equalTo: labelView.topAnchor,constant: 16),
            initialsLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor,constant: -16),
        ]
        
        let imageContactConsts = [
            imageContact.leadingAnchor.constraint(equalTo: labelView.leadingAnchor,constant: 0),
            imageContact.trailingAnchor.constraint(equalTo: labelView.trailingAnchor,constant: 0),
            imageContact.topAnchor.constraint(equalTo: labelView.topAnchor,constant: 0),
            imageContact.bottomAnchor.constraint(equalTo: labelView.bottomAnchor,constant: 0),
            
            ]
        NSLayoutConstraint.activate(mainStackConsts)
        NSLayoutConstraint.activate(labelViewConsts)
        NSLayoutConstraint.activate(imageContactConsts)
        NSLayoutConstraint.activate(deleteAndUndoButtonConsts)
        NSLayoutConstraint.activate(initialsLabelConsts)

        
    }
    
    @objc func didTapDelete() {
        
        let alert = UIAlertController(title: "Delete contact", message: "Are you sure?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes" , style: .destructive) { _ in
            self.deleteContact()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteContact() {
        contactManager.deleteContact(contactToDelete: self.contact)
        deleteButton.isHidden = true
        undodeleteButton.isHidden = false
        progressView.progress = 1
        progressView.isHidden = false
        
        scheduleTimer()
    }
    
    func scheduleTimer() {
        countDown = countDownTotal
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerUI), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerUI() {
        countDown -= 1
        progressView.progress = Float(countDown)/Float(countDownTotal)
        print(progressView.progress)
        if countDown == 0 {
            timer?.invalidate()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTapUndo() {
        timer?.invalidate()
        progressView.progress = 0
        progressView.isHidden = true
        deleteButton.isHidden = false
        undodeleteButton.isHidden = true
        
        contactManager.add(contact: contact)
    }
    
    @objc func didTapEdit() {
        
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
      
        alert.addTextField { textField in
            textField.text = self.contact.firstName
        }
        alert.addTextField { textField in
            textField.text = self.contact.lastName
        }
        alert.addTextField { textField in
            textField.text = self.contact.phoneNumber
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let firstName = alert.textFields![0].text else {
            
                return
            }
            guard let lastName = alert.textFields![1].text else {
                
                return
            }
            guard let phoneNumber = alert.textFields![2].text else {
                
                return
            }
            
            let editedContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, imageData: nil)
            self.save(contact: editedContact)
            self.fullName.text = "\(firstName) \(lastName)"
            self.phoneNumberButton.setTitle(phoneNumber, for: .normal)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(contact: Contact) {
        
        
        contactManager.editContact(contactToEdit: self.contact, editedContact: contact)
        self.contact = contact
        
    }
    
    func open(contactType: ContactType) {
        let phone = contact.phoneNumber
        let phoneWithoutPlus = phone.replacingOccurrences(of: "+", with: "")
        let phoneWithoutWhiteSpaces = phoneWithoutPlus.replacingOccurrences(of: " ", with: "")
        let urlString: String = "\(contactType.urlScheme)" + phoneWithoutWhiteSpaces
        
        guard let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url)
    }
    
    func setupContactContent() {
        initialsLabel.text = "\(contact.firstName.first!) \(contact.lastName.first!)"
        fullName.text = "\(contact.firstName) \(contact.lastName)"
        phoneNumberButton.setTitle(contact.phoneNumber, for: .normal)
    }
    

    func configureGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageContact.addGestureRecognizer(tapGesture)
        imageContact.isUserInteractionEnabled = true
    }

    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker,animated: true,completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    //MARK: - Retrieve image from gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let imageData = image.pngData()
            imageContact.image = image
            imageContact.isHidden = false
          
            
            
            if let imageData = image.pngData() {
                UserDefaults.standard.set(imageData, forKey: "contactImage")
            }
        }
   
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
        
    }
    
}
