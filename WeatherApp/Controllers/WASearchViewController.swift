//
//  WASearchViewController.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
//  Main view controller used to search for the weather conditions in a city

import UIKit

class WASearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    internal var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Setup the view controller as a search results updater of it's search controller
    // Also add the searchbar to the table header view
    
    private func setupSearchController(){
        self.searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = SEARCH_CITY_WEATHER
    }
}

extension WASearchViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension WASearchViewController : UITableViewDelegate {
    
}

extension WASearchViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateSearchResults(for: self.searchController)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchBar.text = ""

    }
}


extension WASearchViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {

        
    }

}

