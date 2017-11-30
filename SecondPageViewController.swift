//
//  SecondPageViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 29/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

class SecondPageViewController: UIPageViewController {
    var pager = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        let proxy = UIPageControl()
//        proxy.pageIndicatorTintColor = .amber
        proxy.currentPageIndicatorTintColor = .red
//        proxy.backgroundColor = .light_blue_l1
//        proxy.currentPage = 1
        self.view.addSubview(self.pager)
        self.pager.translatesAutoresizingMaskIntoConstraints = false
        self.pager.numberOfPages = 3
        self.pager.currentPage = 1
        self.pager.currentPageIndicatorTintColor = .amber
        self.pager.pageIndicatorTintColor = .cyan_d3
        NSLayoutConstraint.activate([
            self.pager.centerXAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.centerXAnchor)!),
            self.pager.bottomAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.bottomAnchor)!, constant: -80),
            self.pager.trailingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.trailingAnchor)!),
            self.pager.leadingAnchor.constraint(equalTo: (self.view?.safeAreaLayoutGuide.leadingAnchor)!),
            ])
        
        
        self.dataSource = self
        self.delegate = self
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

extension SecondPageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var vc : UIViewController?
        if let _ = viewController as? CollectionViewController {
            vc = PictureViewController()
            
        } else if let _ = viewController as? PictureViewController{
            vc = CameraViewController()
            
        } else {
            vc = nil
        }
        return vc
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var vc : UIViewController?
        if let _ = viewController as? PictureViewController {
            vc = CollectionViewController(data: [Any]()) // Collection view controller is after pictureviewcontroller
            
        } else if let _ = viewController as? CameraViewController {
            vc = PictureViewController() // Picture view controller is after Cameraviewcontroller

        } else {
            vc = nil
        }
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 1
    }
    
}


extension SecondPageViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let _ = previousViewControllers[0] as? CameraViewController {
            self.pager.currentPage = 1
        } else if let _ = previousViewControllers[0] as? PictureViewController {
            self.pager.currentPage = 2
        } else {
            self.pager.currentPage = 3
        }
    }
}
