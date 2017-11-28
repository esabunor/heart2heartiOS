//
//  PersonDetailViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 27/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Parse
class PersonDetailViewController: UIViewController {
    
    var objectId: String
    var object: PFObject? = nil
    
    init(objectId: String) {
        
        self.objectId = objectId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let v = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        let lab1 = UILabel()
        let lab2 = UILabel()
        let lab3 = UILabel()
        v.color = .amber
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 10
        self.view.addSubview(v)
        NSLayoutConstraint.activate([
            v.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
        ])
        v.startAnimating()
        let query = PFQuery(className:"Person")
        query.getObjectInBackground(withId:objectId) {
            
            (person: PFObject?, error: Error?) -> Void in
            if error == nil , let person = person {
                self.object = person
                v.stopAnimating()
                v.removeFromSuperview()
                lab1.text = "Name: \(person["name"] as! String)"
                lab2.text = "Email: \(person["email"] as! String)"
                lab3.text = "Age: \(person["age"] as! Int)"
                lab1.translatesAutoresizingMaskIntoConstraints = false
                lab2.translatesAutoresizingMaskIntoConstraints = false
                lab3.translatesAutoresizingMaskIntoConstraints = false
                lab1.sizeToFit()
                lab2.sizeToFit()
                lab3.sizeToFit()
                self.view.addSubview(lab1)
                self.view.addSubview(lab2)
                self.view.addSubview(lab3)
                NSLayoutConstraint.activate([
                    lab1.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                    lab2.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                    lab3.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                    
                    
                    lab1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
                    lab2.topAnchor.constraint(equalTo: lab1.bottomAnchor, constant: 60),
                    lab3.topAnchor.constraint(equalTo: lab2.bottomAnchor, constant: 60),
                ])
                
            } else {
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
