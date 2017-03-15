//
//  WASearchViewController.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
//  Main view controller used to search and display results for the weather conditions in a city

import UIKit

class WASearchViewController: UIViewController {
    let CELL_HEIGHT : CGFloat = 60
    @IBOutlet weak var tableView: UITableView!
    internal var searchController = UISearchController(searchResultsController: nil)
    internal var weatherData : WAWeatherDataObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup search controller
        self.setupSearchController()
        
        // Load conditions for last saved city
        if let city = UserDefaults.standard.value(forKey: CITY) as? String {
            self.searchWeatherConditionsForCity(city: city)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Setup the view controller as a search results updater of it's search controller
    // Also add the searchbar to the table header view
    
    private func setupSearchController(){
        self.definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = SEARCH_CITY_WEATHER
    }
    
    // Method to fetch weather conditions for a specified city
    internal func searchWeatherConditionsForCity(city : String){
        WAWebServiceManager.shared.fetchWeatherConditions(sourceVC: self.searchController, city: city, completionHandler: {[unowned self] (obj) in
            self.weatherData = obj
            if self.weatherData.cityName.isEmpty {
                WAWebServiceErrorHandler.shared.handleError(presentedVC: self.searchController, title: ERROR, message: NSString(format:NO_RESULTS_CITY as NSString,city) as String)
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                WAActivityIndicatorManager.shared.stop()
            }
            
        })
    }
}

extension WASearchViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = self.weatherData {
            return WAWeatherDataCellGenerator.shared.getCell(sourceVC:self, tableView:tableView, indexPath: indexPath, weatherData: data) //Cell provided by factory method
        }
        
        return UITableViewCell()
    }
}

extension WASearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
}

extension WASearchViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.weatherData = nil
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let city = searchBar.text ?? ""
        WAActivityIndicatorManager.shared.start()
        if !city.isEmpty {
            UserDefaults.standard.set(city, forKey: CITY) //Save value of city to user defaults
            self.searchWeatherConditionsForCity(city: city)
        }
    }
}

