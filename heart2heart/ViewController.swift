//
//  ViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 27/7/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signin()
        let button = UIButton()
        button.setTitle("Click", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        self.view = UIView()
    }
    
    func signin() {
        let baseurlstring = "http://192.168.20.5:9000/hello/"
        let headers : HTTPHeaders = ["Authorization":"Token 5866c11078a7558af197b7b3a6dc83718e27c781"]
        
        Alamofire.request(baseurlstring, method: .post, headers: headers).responseJSON {
            response in
            guard let json = response.result.value as? [[String: Any]] else {
                print("didnt get todo object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            
            print(json)
        }
    }


}

