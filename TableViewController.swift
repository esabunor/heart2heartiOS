//
//  TableViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 21/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController , UISearchResultsUpdating {
    
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
        self.registerForPreviewing(with: self, sourceView: self.tableView)
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(valueChange(_:)), for: .valueChanged)
        let search =  UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "2", style: .plain, target: nil, action: nil)
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false
        search.hidesNavigationBarDuringPresentation = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    UIControlEvent for self.tableView.refreshControl
    */
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
}

/*
 3D touch extension
*/
extension TableViewController : UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let path = tableView.indexPathForRow(at: location) else {return nil}
        guard let cell = tableView.cellForRow(at: path) else {return nil}
        let state = cell.textLabel!.text
        switch state! {
        case "WA":
            return ViewController()
        case "ACT":
            return TableViewController()
        case "NSW":
            return AddViewController()
        case "PEOPLE":
            return PeopleTableViewController()
        default:
            return nil
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        (self.parent as! UINavigationController).pushViewController(viewControllerToCommit, animated: true)
    }
}

/*
 TableView extension
*/
extension TableViewController {
    
    var states = ["WA", "ACT", "NSW", "ACT", "QLD", "PEOPLE"]
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = states[indexPath.row]
        
        switch state {
        case "WA":
            (self.parent as! UINavigationController).pushViewController(ViewController(), animated: true)
        case "ACT":
            (self.parent as! UINavigationController).pushViewController(TableViewController(), animated: true)
        case "NSW":
            (self.parent as! UINavigationController).pushViewController(AddViewController(), animated: true)
        case "PEOPLE":
            (self.parent as! UINavigationController).pushViewController(PeopleTableViewController(), animated: true)
        default:
            break
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
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
}
