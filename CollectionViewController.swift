
//
//  CollectionViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 24/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var terms: [Any]?
    
    init(data: [Any]?) {
        self.terms = data
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 30
        layout.itemSize = CGSize(width: 60, height: 80)
        layout.headerReferenceSize = CGSize(width: 80, height: 50)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let header = "header"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header)
        self.collectionView?.backgroundColor = .orange_l3
        self.title = "Collection view"
        self.navigationItem.largeTitleDisplayMode = .always
        
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        let image : UIImage = #imageLiteral(resourceName: "property1")
        let imageView = UIImageView(image: image)
        let v = UIView()
        
        v.layer.borderWidth = 5
        v.layer.cornerRadius = 5
        v.layer.borderColor = UIColor.purple.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(v)
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            v.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            v.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
        ])
        let touchG = UITapGestureRecognizer(target: self, action: #selector(tapG(_:)))
        touchG.numberOfTapsRequired = 1
        touchG.numberOfTouchesRequired = 1
        
        let dtap = UITapGestureRecognizer(target: self, action: #selector(tapG(_:)))
        dtap.numberOfTapsRequired = 2
        dtap.numberOfTouchesRequired = 1
        
        
        switch indexPath.item {
        case let j where j % 2 == 0:
            v.backgroundColor = .teal_d3
            v.addGestureRecognizer(dtap)
        case let j where j % 2 != 0:
            v.backgroundColor = .blue
            v.addGestureRecognizer(touchG)
        default:
            v.backgroundColor = .teal_d3
        }
    
        return cell
    }

    func tapG(_ sender: UITapGestureRecognizer) {
        if sender.numberOfTapsRequired == 2 {
            // double tap to save
            saveToDocumentDirectory()
        } else {
            // tap once to read
            readFromDocumentDirectory()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header, for: indexPath)
        
        //to prevent section header from overlapping check the subview count of cell
        if v.subviews.count == 0 {
            let lab = UILabel()
            lab.textColor = .cyan_d3
            
            lab.backgroundColor = .clear
            lab.translatesAutoresizingMaskIntoConstraints = false
            v.addSubview(lab)
            NSLayoutConstraint.activate([
                lab.topAnchor.constraint(equalTo: v.topAnchor),
                lab.bottomAnchor.constraint(equalTo: v.bottomAnchor),
                lab.leadingAnchor.constraint(equalTo: v.leadingAnchor),
                lab.trailingAnchor.constraint(equalTo: v.trailingAnchor)
                ])
        }
        
        let lab = v.subviews[0] as! UILabel
        lab.text = "Section \(indexPath.section + 1)"
        return v
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension CollectionViewController {
    
    func saveToDocumentDirectory() {
        do {
            //for: .documentDirectory, .applicationSupportDirectory, .cachesDirectory
            let fm = FileManager()
            let docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let mfolder = docsurl.appendingPathComponent("myfolder")
            try fm.createDirectory(at: mfolder, withIntermediateDirectories: true, attributes: nil)
            
            let fileUrl = mfolder.appendingPathComponent("picture.png")
            
            let im : UIImage = #imageLiteral(resourceName: "property1")
            let imData = UIImagePNGRepresentation(im) as! Data
            
            
            try imData.write(to: fileUrl)
        } catch {
            print(error)
        }
    }
    
    
    func readFromDocumentDirectory() -> Void {
        
        do {
            let fm = FileManager()
            let docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let folderurl = docsurl.appendingPathComponent("myfolder")
            let fileurl = folderurl.appendingPathComponent("picture.png")
            
            var imData : Data
            
            try imData = Data(contentsOf: fileurl)
            
            let im = UIImage(data: imData)
            self.view = UIImageView(image: im!)
        } catch {
            print(error)
        }
        
    }
}
