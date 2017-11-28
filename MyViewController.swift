//
//  MyViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 28/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    let ch2 = UITabBarController()
    var constrainsWith = [NSLayoutConstraint]()
    var constrainsWithout = [NSLayoutConstraint]()
    var ch1 = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        let data = [Any]()
        let vc1 = ViewController()
        let vc2 = TableViewController()
        let vc3 = CollectionViewController(data: data)
        
        
        self.ch1 = NavigationViewController(rootViewController: vc2)
        
        
        
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 10)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 11)
        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 12)
        
        vc2.tabBarItem.badgeValue = "9"
        
        ch2.viewControllers = [vc1, vc3]
        
        ////////////////////////////////////
        ch1.view.backgroundColor = .orange
        ch2.view.backgroundColor = .yellow
        self.addChildViewController(ch1)
        self.view.addSubview(ch1.view)
        
        let v = self.view
        
        self.addChildViewController(ch2)
        self.view.addSubview(ch2.view)
        
        ch1.view.translatesAutoresizingMaskIntoConstraints = false
        ch2.view.translatesAutoresizingMaskIntoConstraints = false
        self.constrainsWith = [
            
            ch2.view.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            ch1.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            
            ch1.view.bottomAnchor.constraint(equalTo: ch2.view.topAnchor),
            ch2.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            ch1.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            ch1.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            ch2.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            ch2.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(self.constrainsWith)
        
        ch1.didMove(toParentViewController: self)
        ch2.didMove(toParentViewController: self)
        let swig = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        swig.direction = .left
        swig.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swig)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipe(_ sender: UISwipeGestureRecognizer) {
        let tovc = ViewController()
        self.addChildViewController(tovc)
        ch2.willMove(toParentViewController: nil)
        
        self.transition(from: ch2, to: tovc, duration: 5, options: .curveEaseIn, animations: {
            self.view.addSubview(tovc.view)
            tovc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.deactivate(self.constrainsWith)
            self.constrainsWithout = [
                tovc.view.topAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.ch1.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                
                self.ch1.view.bottomAnchor.constraint(equalTo: tovc.view.topAnchor),
                tovc.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                
                self.ch1.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.ch1.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                
                tovc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                tovc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ]
            NSLayoutConstraint.activate(self.constrainsWithout)
        }){
            _ in
            tovc.didMove(toParentViewController: self)
            self.ch2.removeFromParentViewController()
        }
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
