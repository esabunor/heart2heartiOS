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

class ViewController: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically frdfom a nib.
        signin()
        let button = UIButton()
        button.setTitle("Click", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        self.title = "WA"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        let search =  UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search

        self.navigationItem.prompt = "how are you?"
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
        let baseurlstring = "http://192.168.20.11:9000/resttest/"
        let headers : HTTPHeaders = ["Authorization":"Token 25e8ba9457dfb05a462035595a5259dc8bb61d73"]
        let imageData = UIImageJPEGRepresentation(UIImage(named: "property1.jpg")!, 1.0)
        
        let image = UIImage(named: "property1.jpg")
        
        let request = Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData!, withName: "file", fileName: "property1.jpg", mimeType: "image/jpg")
                multipartFormData.append("aghogho".data(using: .utf8)!, withName: "name")
        },
            to: baseurlstring,
            
            headers: headers,
            
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
        print(request)
    }


}

