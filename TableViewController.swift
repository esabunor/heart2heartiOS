//
//  TableViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 21/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController , UISearchResultsUpdating {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = states[indexPath.row]
        
        switch state {
        case "WA":
            (self.parent as! UINavigationController).pushViewController(ViewController(), animated: true)
        case "ACT":
            (self.parent as! UINavigationController).pushViewController(TableViewController(), animated: true)
        default:
            break
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    var states = ["WA", "ACT", "NSW", "ACT", "QLD"]
    
    init() {
        super.init(style: .plain)
    }
    
    init(states: [String]) {
        self.states = states
        super.init(style: .plain)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Table View"
        self.tableView!.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(valueChange(_:)), for: .valueChanged)
        let search =  UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
        search.hidesNavigationBarDuringPresentation = true;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
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
        return self.states.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell : UITableViewCell!

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell.textLabel!.text = self.states[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func valueChange(_ sender: Any) {
        defer {
            self.tableView.endUpdates()
            (sender as! UIRefreshControl).endRefreshing()
        }
        self.tableView.beginUpdates()
        for (i, s) in self.states.enumerated() {
            self.states[i] = s.lowercased()
        }
        var paths: [IndexPath] = []
        for i in 0...4 {
            paths.append(NSIndexPath(row: i, section: 0) as IndexPath)
        }
        self.tableView.reloadRows(at: paths, with: .automatic)
        
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
