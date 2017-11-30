//
//  PageViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 27/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Parse

class PageViewController: UIPageViewController {
    
    var arr = ["a;ourihgaoeifaj", "audihfa;dfja", "oaehfa;efd"]
    var index = 1
    var objects : [PFObject] = []
    
    init(_ index: Int = 1) {
        self.index = index
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pager = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.pager)
        self.pager.translatesAutoresizingMaskIntoConstraints = false
        self.pager.currentPageIndicatorTintColor = .amber
        self.pager.pageIndicatorTintColor = .cyan_d3
        self.delegate = self
        NSLayoutConstraint.activate([
            self.pager.centerXAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.centerXAnchor)!),
            self.pager.bottomAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.bottomAnchor)!, constant: -80),
            self.pager.trailingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.trailingAnchor)!),
            self.pager.leadingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.leadingAnchor)!),
            ])
        //self.view.addSubview(proxy)
//        let label = UILabel()
//        self.view.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = arr[self.index]
//        label.sizeToFit()
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
//        ])
//        proxy.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//                proxy.centerXAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.centerXAnchor)!),
//                proxy.bottomAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.bottomAnchor)!),
////                proxy.trailingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.trailingAnchor)!),
////                proxy.leadingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.leadingAnchor)!),
//        ])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPFObjects(_ objects: [PFObject]) {
        self.objects = objects
        
        self.pager.numberOfPages = self.objects.count
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        for view in self.view.subviews{
//            if view is UIScrollView{
//                view.frame =  UIScreen.main.bounds
//            } else if view is UIPageControl{
//                view.backgroundColor = .light_blue_l1
//
//            }
//        }
//    }

}


extension PageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? PersonDetailViewController else {
            return nil
        }
        
        let arrid = self.objects.map{$0.objectId!}
        let index = arrid.index{$0 == vc.objectId}!
        let ix = index - 1
        
        if ix < 0 {
            return nil
        } else {
            return PersonDetailViewController(objectId: self.objects[ix].objectId!)
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? PersonDetailViewController else {
            return nil
        }
        
        let arrid = self.objects.map{$0.objectId!}
        let index = arrid.index{$0 == vc.objectId}!
        let ix = index + 1
        
        if ix >= self.objects.count {
            return nil
        } else {
            return PersonDetailViewController(objectId: self.objects[ix].objectId!)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.objects.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let vc = pageViewController.viewControllers![0] as? PersonDetailViewController else {
            return 0
        }
        let arrid = self.objects.map{$0.objectId!}
        let ind = arrid.index{$0 == vc.objectId}!
        return ind
    }
}

extension PageViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let vc = pageViewController.childViewControllers[0] as? PersonDetailViewController {
            let arrid = self.objects.map{$0.objectId!}
            let ind = arrid.index{$0 == vc.objectId}!
            self.pager.currentPage = ind
        }
    }
}
