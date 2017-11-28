//
//  PeopleTableViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 23/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Parse

class PeopleTableViewController: UITableViewController {
    
    var objects : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "People"
        let tag = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tag.numberOfTapsRequired = 1
        tag.numberOfTouchesRequired = 1
        let t = UILabel()
        t.text = self.title
        t.addGestureRecognizer(tag)
        t.sizeToFit()
        self.navigationItem.titleView = t
        self.navigationItem.titleView?.isUserInteractionEnabled = true
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        var query = PFQuery(className:"Person")
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.beginRefreshing()
        self.tableView.refreshControl?.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.objects = objects
                    for object in objects {
                        print(object["name"])
                        print(object["email"])
                        print(object["age"])
                    }
                }
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            } else {
                // Log details of the failure
                print("Error: \(error!) ")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = self.objects[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = "\(self.objects[indexPath.row]["email"] as! String) \(self.objects[indexPath.row]["age"] as! Int)"
        cell.accessoryType = .disclosureIndicator
        // Configure the cell...

        return cell
    }

    func valueChanged(_ sender: Any) -> Void {
        var query = PFQuery(className:"Person")
        self.tableView.reloadData()
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.objects = objects
                    for object in objects {
                        print(object["name"])
                        print(object["email"])
                        print(object["age"])
                    }
                }
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            } else {
                // Log details of the failure
                print("Error: \(error!) ")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch objects[indexPath.row] {
        case let obj:
            (self.parent as! UINavigationController).pushViewController(PersonDetailViewController(objectId: obj.objectId!), animated: true)
        }
    }
    
    
    func tap(_ sender: UITapGestureRecognizer) {
        print("tapped")
        (self.parent as! UINavigationController).pushViewController(ScrollViewController(), animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
