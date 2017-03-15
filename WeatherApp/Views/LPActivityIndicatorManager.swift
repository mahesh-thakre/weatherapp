//
//  WAActivityIndicatorManager.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
//  Manages progress activity display/dismissal

import UIKit

class WAActivityIndicatorManager {
    
    static let shared = WAActivityIndicatorManager()
    
    var indicatorView = Bundle.main.loadNibNamed("WALoadingView", owner: nil, options: nil)?.last as! WALoadingView
    
    func start(){
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(indicatorView)
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[iv]|", options: [], metrics: nil, views: ["iv":indicatorView]))
            window.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[iv]|", options: [], metrics: nil, views: ["iv":indicatorView]))

            indicatorView.activityIndicator.startAnimating()
        }
    }
    
    func stop(){
        indicatorView.removeFromSuperview()
        indicatorView.activityIndicator.stopAnimating()
    }
}

