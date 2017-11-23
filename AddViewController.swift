//
//  AddViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 23/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Parse

class AddViewController: UIViewController {
    let nameField = UITextField()
    let emailField = UITextField()
    let ageField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        let button2 = UIButton(type: .system)
        button2.setTitle("Add Person", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(resign(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(add(_:)), for: .touchUpInside)
        
        nameField.placeholder = "Name"
        nameField.keyboardType = .asciiCapable
        nameField.borderStyle = .roundedRect
        
        emailField.borderStyle = .roundedRect
        emailField.placeholder = "Email"
        emailField.keyboardType = .emailAddress
        
        ageField.placeholder = "Age"
        ageField.borderStyle = .roundedRect
        ageField.keyboardType = .numberPad
        
        let guide = UILayoutGuide()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        ageField.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.title = "Add more items"
        
        self.view.addLayoutGuide(guide)
        self.view.addSubview(button)
        self.view.addSubview(nameField)
        self.view.addSubview(emailField)
        self.view.addSubview(ageField)
        self.view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            guide.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            guide.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            button2.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 80),
            button2.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            
            nameField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 30),
            ageField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            
            nameField.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            ageField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            ageField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            button2.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 50)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func resign(_ sender: Any) {
        for v in self.view.subviews {
            v.resignFirstResponder()
        }
    }
    
    func add(_ sender: Any) {
        guard let name = self.nameField.text, name != "" else {return}
        guard let email = self.emailField.text, email != "" else {return}
        guard let age1 = self.ageField.text, let age = Int(age1) else {return}
        var person = PFObject(className: "Person")
        for v in self.view.subviews {
            if v is UITextField {
                (v as! UITextField).text = ""
            }
        }
        person["name"] = name
        person["email"] = email
        person["age"] = age
        person.saveInBackground()
    }
}
