//
//  ScrollViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 26/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        self.title = "Scroll VC"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        
        self.view.backgroundColor = .amber
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        self.view.addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.topAnchor)!),
            sv.bottomAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.bottomAnchor)!),
            sv.leadingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.leadingAnchor)!),
            sv.trailingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.trailingAnchor)!),

        ])
        
        var con = [NSLayoutConstraint]()
        var prevLab : UILabel? = nil
        for i in 0...20 {
            let lab = UILabel()
            sv.addSubview(lab)
            lab.translatesAutoresizingMaskIntoConstraints = false
            lab.text = "label \(i)"
            lab.textAlignment = .center
            con.append(lab.centerXAnchor.constraint(equalTo: sv.centerXAnchor))
            lab.sizeToFit()
            con.append(lab.heightAnchor.constraint(equalToConstant: 50))
            if let prevLab = prevLab {
                //middle views
                con.append(lab.topAnchor.constraint(equalTo: prevLab.bottomAnchor))

            } else {
                //first view
                con.append(lab.topAnchor.constraint(equalTo: sv.topAnchor))
            }
            
            prevLab = lab
        }
            //last view
            con.append(prevLab!.bottomAnchor.constraint(equalTo: sv.bottomAnchor))
        NSLayoutConstraint.activate(con)
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
