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

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let nc = UINavigationController(rootViewController: controller.presentedViewController)
        nc.topViewController?.navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        return nc
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAdd(_:)))
        
        let search =  UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search

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

    func  presentAdd(_ sender: Any) {
        let avc = AddViewController()
        avc.modalPresentationStyle = .popover
        avc.popoverPresentationController?.delegate = self
        self.present(avc, animated: true, completion: nil)
    }
    
    func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

