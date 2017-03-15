//
//  WALoadingView.swift
//  WeatherApp
//
//  Created by Mahesh Thakre on 3/14/17.
//  Copyright © 2017 Mahesh Thakre. All rights reserved.
//
//  Used as a progress indicator

import UIKit

class WALoadingView: UIView {
    
    @IBOutlet weak var box: UIView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.box.layer.cornerRadius = 5.0
        self.box.layer.masksToBounds = false
        self.box.layer.shadowRadius = 10.0
        self.box.layer.opacity = 0.8
        self.box.layer.shadowColor = UIColor.black.cgColor
        self.box.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        self.box.layer.shadowPath = UIBezierPath(roundedRect: self.box.bounds, cornerRadius: 5.0).cgPath
    }

}
