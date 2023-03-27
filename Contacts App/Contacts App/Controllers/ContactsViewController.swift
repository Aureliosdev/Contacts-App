//
//  ViewController.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 23.02.2023.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImagePickerDelegate {

    
    let contactManager = ContactManager()
    let imagePicker = UIImagePickerController()
    var selectedIndexPath: IndexPath?
    var selectedImage: UIImage?
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        
        return table
    }()
    
    private let segmentedControl: UISegmentedControl = {
       let items = ["First name", "Last name"]
        let segment = UISegmentedControl(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        
        return segment
        
    }()
    
    private let searchTextField: UISearchBar = {
        let field = UISearchBar()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Search Contact"
        field.autocapitalizationType = .words
        field.backgroundImage = UIImage()
        field.autocapitalizationType = .none
        return field
    }()
    
    var arrayOfContacts: [ContactGroup] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var filteredContacts: [Contact] = []
    var contacts = [Contact]()
    var isSearchBarActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(segmentedControl)
        view.addSubview(searchTextField)
       
        let addContact =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateContact))
        addContact.tintColor = .label
        let premiumButton =  UIBarButtonItem(image: UIImage(systemName: "crown.fill"), style: .plain, target: self, action: #selector(didTapPremium))
        
        premiumButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItems = [addContact,premiumButton]
//        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.title = "Contacts"
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadDataSource), for: .valueChanged)
        segmentedControl.addTarget(self, action: #selector(didTapValueChanged), for: .valueChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataSource()
        
    }
    
    @objc func didTapValueChanged() {
        reloadDataSource()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            segmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 70),
            segmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -70),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            
            searchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 10),
            searchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -10),
            searchTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor,constant: 10),
            
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor,constant: 1)
        
        ])
    }
    @objc private func didTapCreateContact() {
        let alert = UIAlertController(title: "Add contact", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "First name.."
            textField.textAlignment = .center
        }
        alert.addTextField { textField in
            textField.placeholder = "Last name.."
            textField.textAlignment = .center
        }
        alert.addTextField { textField in
            textField.placeholder = "Phone number.."
            textField.textAlignment = .center
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let firstName = alert.textFields![0].text, !firstName.isEmpty else {
                self.showErrorMesage(message: "First name is Empty")
                return
            }
            guard let lastName = alert.textFields![1].text, !lastName.isEmpty else {
                self.showErrorMesage(message: "Last name is Empty")
                return
            }
            guard let phoneNumber = alert.textFields![2].text, !phoneNumber.isEmpty else {
                self.showErrorMesage(message: "Phone number is Empty")
                
                return
            }
            guard phoneNumber.isValidPhoneNumber() else {
                self.showErrorMesage(message: "Incorrect phone number")
                return
            }
            
            let contact =   Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, imageData: nil)
            self.add(contact: contact)
          
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func showErrorMesage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func add(contact: Contact ) {
        contactManager.add(contact: contact)
        self.reloadDataSource()
    }
    
    
    @objc private func didTapPremium() {
        let vc = UINavigationController(rootViewController:  PayWallViewController())
//        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func reloadDataSource() {
        
        tableView.refreshControl?.beginRefreshing()
        
        
        var dictionary: [String: [Contact]] = [:]
        
        let allContacts = contactManager.getAllContacts()
        
        
        allContacts.forEach { contact in
            var key: String!
            
            if segmentedControl.selectedSegmentIndex == 0 {
                key = String(contact.firstName.first!)
            }else if segmentedControl.selectedSegmentIndex == 1 {
                key = String(contact.lastName.first!)
            }
            
            if var existingContacts = dictionary[key] {
                existingContacts.append(contact)
                
                dictionary[key] = existingContacts
            }else  {
                dictionary[key] = [contact]
            }
            
        }
        
        var arrayOfContactGroup: [ContactGroup] = []
        
        let alphabeticallyOrderedKeys : [String] = dictionary.keys.sorted { key1, key2 in
            return key1 < key2
            
        }
        alphabeticallyOrderedKeys.forEach { key in
            let contacts = dictionary[key]
            
            let contactGroup  = ContactGroup(title: key, contacts: contacts!)
            
            arrayOfContactGroup.append(contactGroup)
        }
        
        
        tableView.refreshControl?.endRefreshing()
        self.arrayOfContacts = arrayOfContactGroup
    }
    
    func getContact(indexPath: IndexPath) -> Contact {
        let getContactGroup = arrayOfContacts[indexPath.section]
        let contact = getContactGroup.contacts[indexPath.row]
        
        return contact
    }
    
    
    
    func deleteContact(indexPath: IndexPath) {
        let contact = arrayOfContacts[indexPath.section].contacts.remove(at: indexPath.row)
        
        if arrayOfContacts[indexPath.section].contacts.count < 1 {
            arrayOfContacts.remove(at: indexPath.section)
        }
        contactManager.deleteContact(contactToDelete: contact)
    }
    
    func imagePickerDidFinishPicking(imageData: Data?) {
         if let selectedIndexPath = tableView.indexPathForSelectedRow {
            filteredContacts[selectedIndexPath.row].imageData = imageData
             tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
         }
     }


    func filterContacts(for searchText: String) -> [Contact] {
        var filteredContacts = [Contact]()
        
        for group in arrayOfContacts {
            let filteredGroupContacts = group.contacts.filter { contact in
                return contact.firstName.lowercased().contains(searchText.lowercased()) || contact.lastName.lowercased().contains(searchText.lowercased())
            }
            filteredContacts.append(contentsOf: filteredGroupContacts)
        }
        
        return filteredContacts
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier, for: indexPath) as! ContactsTableViewCell
        let contactsToDisplay = isSearchBarActive ? filteredContacts : arrayOfContacts[indexPath.section].contacts
        
        let contact = contactsToDisplay[indexPath.row]
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.contactLabel.text = "\(contact.firstName) \(contact.lastName)"
            

        }else if segmentedControl.selectedSegmentIndex == 1 {
            cell.contactLabel.text = "\(contact.lastName) \(contact.firstName)"

        }
        if let imageData = UserDefaults.standard.data(forKey: "contactImage"), indexPath == selectedIndexPath {
            cell.imageView!.image = UIImage(data: imageData)
            } else {
                cell.imageView!.image = nil
            }
        
    
        
        return cell
    }
	

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarActive ? filteredContacts.count : arrayOfContacts[section].contacts.count
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width / 7
    }
    func numberOfSections(in tableView: UITableView) -> Int {

        return isSearchBarActive ? filteredContacts.count : arrayOfContacts.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayOfContacts[section].title
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteContact(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       let contact =  getContact(indexPath: indexPath)
     
        let vc = DetailedViewController()
        vc.contact = contact
        navigationController?.pushViewController(vc, animated: true)
    
    }
}
extension ContactsViewController: UISearchBarDelegate {
    
 
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        searchTextField.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContacts = filterContacts(for: searchText)
        isSearchBarActive = !searchText.isEmpty
        print("isSearchBarActive: \(isSearchBarActive), filteredContacts: \(filteredContacts)")
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       isSearchBarActive = false
        tableView.reloadData()
    }
}

