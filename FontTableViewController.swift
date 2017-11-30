//
//  FontTableViewController.swift
//  heart2heart
//
//  Created by Tega Esabunor on 30/11/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit


class FontTableViewController: UITableViewController, UISearchResultsUpdating {
    
    struct C {
        var familyName : String?
        var fontNames : Optional<[String]>
    }
    var array : [C] = [C]()
    var filteredarray : [C] = [C]()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        let text1 = searchController.searchBar.text
        guard let text = text1, !text.isEmpty else {return}
        let stuf = self.array.flatMap{$0.fontNames!}.filter{$0.contains(text)}
        print(stuf)
        self.filteredarray = [C(familyName: "Results", fontNames: stuf)]
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredarray[section].fontNames!.count : array[section].fontNames!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .detailDisclosureButton
        
        let fontName = isFiltering() ? self.filteredarray[indexPath.section].fontNames![indexPath.row] : self.array[indexPath.section].fontNames![indexPath.row]
        cell.textLabel?.attributedText = NSAttributedString(string: fontName, attributes: [NSFontAttributeName: UIFont(name: fontName, size:16)!])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName : String = isFiltering() ? self.filteredarray[section].familyName! : self.array[section].familyName!
        
        return sectionName
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(isFiltering())
        return isFiltering() ? filteredarray.count : array.count
    }
    
    
    func isFiltering() -> Bool {
        return self.navigationItem.searchController!.isActive && !(self.navigationItem.searchController?.searchBar.text?.isEmpty)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let search =  UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        self.definesPresentationContext = true
        UIFont.familyNames.forEach {
            family in
            var c : C = C(familyName: "Empty", fontNames: [String]())
            UIFont.fontNames(forFamilyName: family).forEach {
                c.familyName = family
                c.fontNames?.append($0)
            }
            if let _ = c.familyName, let names = c.fontNames , !names.isEmpty {
                self.array.append(c)
                self.filteredarray.append(c)
            }
        }
        let tbv2 = self
        self.tableView.reloadData()
        tbv2.title = "My TableView"
        let sc = UISegmentedControl(items: ["first", "second"])
        
        sc.selectedSegmentIndex = 0
        tbv2.navigationItem.titleView = sc
        tbv2.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
        tbv2.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        //important
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

extension FontTableViewController : UISearchControllerDelegate, UISearchBarDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tableView.isScrollEnabled = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.isScrollEnabled = true
    }
}
