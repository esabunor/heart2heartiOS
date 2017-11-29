//
//  PictureViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 29/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
import UserNotifications

class PictureViewController: UIViewController {
    let sc = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = UIButton(type: .system)
        b.setTitle("Pick a Photo", for: .normal)
        self.view.addSubview(b)
        b.addTarget(self, action: #selector(presentImagePicker(_:)), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        sc.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sc)
        
        NSLayoutConstraint.activate([
            b.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            b.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            sc.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sc.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            sc.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            sc.heightAnchor.constraint(equalToConstant: 150)
        ])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        determineStatus()
        let content = UNMutableNotificationContent()
        content.title = "Swifting.io Notifications"
        
        let trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 1,  repeats: false)
        let request = UNNotificationRequest(identifier: "Consts.requestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            UNUserNotificationCenter.current().delegate = self
            if (error != nil){
                //handle here
            }
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 23
        fetchImages()
    }
    
    func presentImagePicker(_ sender: UIButton) {
        let ok = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        if ok {
            let imp = UIImagePickerController()
            imp.mediaTypes = [kUTTypeImage as String]
            imp.sourceType = .photoLibrary
            imp.delegate = self
            self.present(imp, animated: true, completion: nil)
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
    
    func determineStatus() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization{_ in}
            return false
        case .restricted:
            return false
        case .denied:
            print("denied")
            let alert = UIAlertController(title: "Need Photo Access", message: "Access to your photo album would be greate for this app", preferredStyle: .alert)
            let action = UIAlertAction(title: "No", style: .cancel, handler: nil)
            let ok = UIAlertAction(title: "Ok", style: .default) {
                _ in
                let url = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.applicationIconBadgeNumber = 1
                UIApplication.shared.open(url)
            }
            alert.addAction(ok)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    func fetchImages() {
        let assetCollection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pickImage(_:)))
        
        gesture.numberOfTapsRequired = 1
        guard let firstAssetColl = assetCollection.firstObject else {return}
        
        let assets = PHAsset.fetchAssets(in: firstAssetColl, options: nil)
        var con = [NSLayoutConstraint]()
        var prevImv : UIImageView? = nil
        for assin in 0..<assets.count {
            let ass = assets.object(at: assin)
            let size = CGSize(width: 150, height: 150)
            PHImageManager.default().requestImage(for: ass, targetSize: size, contentMode: .aspectFit, options: nil, resultHandler: { (image, stuff) in
                
                guard let im = image else {return}
                let iv = UIImageView(image: im)
                self.sc.addSubview(iv)
                iv.addGestureRecognizer(gesture)
                iv.translatesAutoresizingMaskIntoConstraints = false
//                con.append(iv.widthAnchor.constraint(equalToConstant: 150)
//                con.append(iv.heightAnchor.constraint(equalToConstant: 150))
                con.append(iv.topAnchor.constraint(equalTo: self.sc.topAnchor))
                con.append(iv.bottomAnchor.constraint(equalTo: self.sc.bottomAnchor))
                
                if let prevImv = prevImv {
                    // other im views
                    
                    con.append(iv.leadingAnchor.constraint(equalTo: prevImv.trailingAnchor, constant: 15))
                    
                } else {
                    //first view
                    con.append(iv.leadingAnchor.constraint(equalTo: self.sc.leadingAnchor, constant: 15))
                }
                prevImv = iv
            })
        }
        
        con.append(prevImv!.trailingAnchor.constraint(equalTo: self.sc.trailingAnchor, constant: 15))
        NSLayoutConstraint.activate(con)
        
    }
    
    func pickImage(_ sender: UITapGestureRecognizer) {
        let loc = sender.location(in: sc)
        guard let im = sc.hitTest(loc, with: nil) as? UIImageView else {return}
        let image = im.image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        
    }
}
extension PictureViewController : UINavigationControllerDelegate {
    
}

extension PictureViewController : UNUserNotificationCenterDelegate {
    
}

extension PictureViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let _ : URL = info[UIImagePickerControllerReferenceURL] as! URL
        
        self.view.subviews[0].removeFromSuperview()
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        self.dismiss(animated: true, completion: nil)
    }
}

