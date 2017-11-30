//
//  CameraViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 30/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class CameraViewController: UIViewController {
    var pictureTaken = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    let picker = UIImagePickerController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let ok = UIImagePickerController.isSourceTypeAvailable(.camera)
        if ok && !self.pictureTaken {
            picker.sourceType = .camera
            picker.delegate = self
            picker.mediaTypes = [kUTTypeImage as String]
            picker.showsCameraControls = false
            let f = self.view.window!.bounds
            let v = UIView(frame: f)
//
            
            v.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
            tap.numberOfTapsRequired = 1
            v.addGestureRecognizer(tap)
            picker.cameraOverlayView!.addSubview(v)

            self.present(picker, animated: true, completion: nil)
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
    func tap(_ sender: UITapGestureRecognizer) {
        self.picker.takePicture()
        print("tapped")
        self.dismiss(animated: true, completion: nil)
    }

}

extension CameraViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
            
        let imageView = UIImageView(image: image)
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        self.pictureTaken = true
        self.dismiss(animated: true, completion: nil)
    }
}

extension CameraViewController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationController.toolbar.isTranslucent = true
        navigationController.isToolbarHidden = false
        
        let baritem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let baritem1 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(clickedCancel(_:)))
        let baritem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickedDone(_:)))
        navigationController.toolbar.setItems([baritem1, baritem, baritem2], animated: true)
        print("picker calle")
        
    }
    
    func clickedCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func clickedDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}


