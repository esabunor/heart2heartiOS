//
//  SecondPageViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 29/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

class SecondPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        let proxy = UIPageControl.appearance(whenContainedInInstancesOf: [SecondPageViewController.self])
        proxy.pageIndicatorTintColor = .amber
        proxy.currentPageIndicatorTintColor = .red
        proxy.backgroundColor = .light_blue_l1
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
        } else {
            vc = nil
        }
        return vc
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var vc : UIViewController?
        if let _ = viewController as? PictureViewController {
            vc = CollectionViewController(data: [Any]())
        } else {
            vc = nil
        }
        return vc
    }
    
    
}
