//
//  SecondScrollViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 27/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

class SecondScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var pager = UIPageControl()
    let sv = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Second Scroll VC"
        let sc = UISegmentedControl(items: ["first", "second", "third"])
        sc.selectedSegmentIndex = 0
        self.navigationItem.titleView = sc
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.delegate = self
        self.view.addSubview(sv)
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.topAnchor)!),
            sv.bottomAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.bottomAnchor)!),
            sv.leadingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.leadingAnchor)!),
            sv.trailingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.trailingAnchor)!),
        ])
        sv.backgroundColor = .light_blue_l1
        var con = [NSLayoutConstraint]()
        sv.isPagingEnabled = true
        var prevView: UIView? = nil
        for i in 0..<3 {
            // three views
            let view = UIView()
            sv.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            switch i {
            case 0:
                view.backgroundColor = .lime
            case 1:
                view.backgroundColor = .amber
            case 2:
                view.backgroundColor = .cyan_a4
            default:
                break
            }
            
            con.append(view.heightAnchor.constraint(equalToConstant: self.view.bounds.height))
            con.append(view.widthAnchor.constraint(equalToConstant: self.view.bounds.width))
            if let prevView = prevView {
                // other views
                // make the almost fullscreen
                con.append(view.leadingAnchor.constraint(equalTo: prevView.trailingAnchor))
                
            } else {
                // first view
                
                con.append(view.leadingAnchor.constraint(equalTo: sv.leadingAnchor))
            }
            prevView = view
            
        }
        con.append((prevView?.trailingAnchor.constraint(equalTo: sv.trailingAnchor))!)
        NSLayoutConstraint.activate(con)
        // Do any additional setup after loading the view.
        self.view.addSubview(self.pager)
        self.pager.translatesAutoresizingMaskIntoConstraints = false
        self.pager.numberOfPages = 3
        NSLayoutConstraint.activate([
            self.pager.centerXAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.centerXAnchor)!),
            self.pager.bottomAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.bottomAnchor)!, constant: 80),
            self.pager.trailingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.trailingAnchor)!),
            self.pager.leadingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.leadingAnchor)!),
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = self.sv.contentOffset.x
        let w = self.sv.bounds.size.width
        self.pager.currentPage = Int(x/w)
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
